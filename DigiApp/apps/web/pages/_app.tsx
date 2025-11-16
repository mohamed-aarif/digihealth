import React from 'react';
import type { AppProps } from 'next/app';
import { AuthProvider } from '@digihealth/core';

export default function App({ Component, pageProps }: AppProps) {
  return (
    <AuthProvider>
      <Component {...pageProps} />
    </AuthProvider>
  );
}
