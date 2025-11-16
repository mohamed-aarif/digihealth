import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,

  // Important: transpile workspace packages
  transpilePackages: ['@digihealth/core', '@digihealth/ui'],

  webpack: (config) => {
    // Force a single React + ReactDOM instance
    config.resolve.alias = {
      ...(config.resolve.alias || {}),
      react: path.join(__dirname, 'node_modules/react'),
      'react-dom': path.join(__dirname, 'node_modules/react-dom'),
    };

    return config;
  },
};

export default nextConfig;