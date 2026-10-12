import { build } from 'esbuild';
import { copyFile, mkdir, rm } from 'node:fs/promises';
import { resolve } from 'node:path';

const root = resolve(import.meta.dirname);
const dist = resolve(root, 'dist');
await rm(dist, { recursive: true, force: true });
await mkdir(resolve(dist, 'assets'), { recursive: true });
await build({
  entryPoints: [resolve(root, 'src/app.js')],
  bundle: true,
  platform: 'browser',
  target: 'es2020',
  format: 'iife',
  outfile: resolve(dist, 'assets/app.js'),
  minify: true,
  legalComments: 'eof',
  logLevel: 'info',
});
await copyFile(resolve(root, 'src/style.css'), resolve(dist, 'assets/app.css'));
await copyFile(resolve(root, 'index.html'), resolve(dist, 'index.html'));
