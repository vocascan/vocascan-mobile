const { program } = require('commander');
const Listr = require('listr');
const path = require('path');
const fs = require('fs-extra');

program
  .option(
    '-r, --frontend-repository <url>',
    'use this repository for building the frontend app',
    'https://github.com/vocascan/vocascan-frontend.git',
  )
  .option(
    '-b, --frontend-branch <branch>',
    'use this branch of the frontend repository for building the frontend app',
    'main',
  )
  .option('--ios', 'build the ios app')
  .option('--android', 'build the android app')
  .option('--apk', 'generate an apk file for android', false);

program.parse();

const options = program.opts();

if (!options.ios && !options.android) {
  throw new Error('No build platform specified (--ios, --android)');
}

const PROJECT_ROOT_DIR = path.resolve(__dirname, '..');
const TEMP_DIR = path.resolve(PROJECT_ROOT_DIR, 'temp');
const ANDROID_DIR = path.resolve(PROJECT_ROOT_DIR, 'android');
const OUTPUT_DIR = path.resolve(PROJECT_ROOT_DIR, 'outputs');
const ANDROID_ASSETS_DIR = path.resolve(
  ANDROID_DIR,
  'app',
  'src',
  'main',
  'assets',
);
const ANDROID_BUILD_DIR = path.resolve(ANDROID_DIR, 'app', 'build');

const VOCASCAN_FRONTEND_DIR = path.resolve(TEMP_DIR, 'vocascan-frontend');
const VOCASCAN_FRONTEND_BUILD_SRC = path.resolve(
  VOCASCAN_FRONTEND_DIR,
  'build',
);
const VOCASCAN_FRONTEND_BUILD_DEST = path.resolve(ANDROID_ASSETS_DIR, 'build');

const ANDROID_BUNDLE_FILE_NAME = 'app-release.aab';
const ANDROID_BUNDLE_SRC = path.resolve(
  ANDROID_BUILD_DIR,
  'outputs',
  'bundle',
  'release',
);
const ANDROID_BUNDLE_DEST = path.resolve(OUTPUT_DIR, 'android', 'bundle');

const ANDROID_APK_FILE_NAME = 'app-release.apk';
const ANDROID_APK_SRC = path.resolve(
  ANDROID_BUILD_DIR,
  'outputs',
  'apk',
  'release',
);
const ANDROID_APK_DEST = path.resolve(OUTPUT_DIR, 'android', 'apk');

(async () => {
  const { execaCommand } = await import('execa');

  const tasks = new Listr([
    {
      title: 'Pull vocascan-frontend',
      task: async () => {
        await fs.ensureDir(TEMP_DIR);
        await fs.remove(VOCASCAN_FRONTEND_DIR);
        return execaCommand(
          `git clone --depth 1 --single-branch --branch ${options.frontendBranch} ${options.frontendRepository}`,
          {
            cwd: TEMP_DIR,
          },
        );
      },
    },
    {
      title: 'Install Dependencies',
      task: () =>
        new Listr(
          [
            {
              title: 'vocascan-mobile',
              task: () => execaCommand('yarn install'),
            },
            {
              title: 'vocascan-frontend',
              task: () =>
                execaCommand('npm install', {
                  cwd: VOCASCAN_FRONTEND_DIR,
                }),
            },
          ],
          { concurrent: true },
        ),
    },
    {
      title: 'Build vocascan-frontend',
      task: () => execaCommand('npm run build', { cwd: VOCASCAN_FRONTEND_DIR }),
    },
    {
      title: 'Prepare app builds',
      task: () =>
        new Listr(
          [
            {
              title: 'Prepare android build',
              enabled: ctx => ctx.android,
              task: async () => {
                await fs.ensureDir(ANDROID_ASSETS_DIR);
                await fs.copy(
                  VOCASCAN_FRONTEND_BUILD_SRC,
                  VOCASCAN_FRONTEND_BUILD_DEST,
                );
              },
            },
            {
              title: 'Prepare iOS build',
              enabled: ctx => ctx.ios,
              skip: () => 'Not implemented',
              task: () => {},
            },
          ],
          { concurrent: true },
        ),
    },
    {
      title: 'Build apps',
      task: () =>
        new Listr(
          [
            {
              title: 'Build android app',
              enabled: ctx => ctx.android,
              task: async (ctx, task) => {
                if (ctx.apk) {
                  task.title = `${task.title} (apk)`;
                  return execaCommand('gradlew assembleRelease', {
                    cwd: ANDROID_DIR,
                  });
                }
                return execaCommand('gradlew bundleRelease', {
                  cwd: ANDROID_DIR,
                });
              },
            },
            {
              title: 'Build iOS app',
              enabled: ctx => ctx.ios,
              skip: () => 'Not implemented',
              task: () => {},
            },
          ],
          { concurrent: true },
        ),
    },
    {
      title: 'Write output files',
      task: () =>
        new Listr(
          [
            {
              title: 'Write android build',
              enabled: ctx => ctx.android,
              task: async (ctx, task) => {
                if (ctx.apk) {
                  await fs.ensureDir(ANDROID_APK_DEST);
                  task.title = `${task.title} (apk)`;
                  return fs.copyFile(
                    path.resolve(ANDROID_APK_SRC, ANDROID_APK_FILE_NAME),
                    path.resolve(ANDROID_APK_DEST, ANDROID_APK_FILE_NAME),
                  );
                }
                fs.ensureDir(ANDROID_BUNDLE_DEST);
                return fs.copyFile(
                  path.resolve(ANDROID_BUNDLE_SRC, ANDROID_BUNDLE_FILE_NAME),
                  path.resolve(ANDROID_BUNDLE_DEST, ANDROID_BUNDLE_FILE_NAME),
                );
              },
            },
            {
              title: 'Write iOS build',
              enabled: ctx => ctx.ios,
              skip: () => 'Not implemented',
              task: () => {},
            },
          ],
          { concurrent: true },
        ),
    },
  ]);

  tasks.run(options);
})();
