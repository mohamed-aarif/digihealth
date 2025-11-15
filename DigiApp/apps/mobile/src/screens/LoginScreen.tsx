import React from 'react';
import { View, Text } from 'react-native';
import { Button } from '@digihealth/ui/src/Button';
import { useAuth } from '@digihealth/core';
export default function LoginScreen() {
  const { setRoleForDemo } = useAuth();
  return (
    <View style={{ flex:1, alignItems:'center', justifyContent:'center', padding:20 }}>
      <Text style={{ fontSize:20, marginBottom:16 }}>DigiHealth Demo Login</Text>
      <Button title="Sign in as Patient" onPress={() => setRoleForDemo && setRoleForDemo('PATIENT')} />
      <View style={{ height:12 }} />
      <Button title="Sign in as Doctor" onPress={() => setRoleForDemo && setRoleForDemo('DOCTOR')} />
      <View style={{ height:12 }} />
      <Button title="Sign in as Family" onPress={() => setRoleForDemo && setRoleForDemo('FAMILY')} />
    </View>
  );
}
