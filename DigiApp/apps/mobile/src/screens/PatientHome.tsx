import React from 'react';
import { View, Text } from 'react-native';
import { Button } from '@digihealth/ui/src/Button';
import { useAuth } from '@digihealth/core';
export default function PatientHome() {
  const { setRoleForDemo } = useAuth();
  return (
    <View style={{flex:1, padding:16}}>
      <Text style={{fontSize:22}}>Patient Dashboard</Text>
      <View style={{height:12}} />
      <Button title="Switch to Doctor (demo)" onPress={() => setRoleForDemo && setRoleForDemo('DOCTOR')} />
    </View>
  );
}
