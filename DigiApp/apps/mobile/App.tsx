import React from 'react';
import { AuthProvider } from '@digihealth/core';
import RootNavigator from './src/navigation/RootNavigator';
export default function App() {
  return (
    <AuthProvider>
      <RootNavigator />
    </AuthProvider>
  );
}
