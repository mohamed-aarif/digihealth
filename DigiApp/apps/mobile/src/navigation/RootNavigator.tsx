import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { useAuth } from '@digihealth/core';
import PatientHome from '../screens/PatientHome';
import DoctorHome from '../screens/DoctorHome';
import FamilyHome from '../screens/FamilyHome';
import LoginScreen from '../screens/LoginScreen';
import { NavigationContainer } from '@react-navigation/native';
const Stack = createNativeStackNavigator();
export default function RootNavigator() {
  const { role, loading } = useAuth();
  if (loading) return null;
  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={{ headerShown: false }}>
        {!role && <Stack.Screen name="Login" component={LoginScreen} />}
        {role === 'PATIENT' && <Stack.Screen name="PatientHome" component={PatientHome} />}
        {role === 'DOCTOR' && <Stack.Screen name="DoctorHome" component={DoctorHome} />}
        {role === 'FAMILY' && <Stack.Screen name="FamilyHome" component={FamilyHome} />}
      </Stack.Navigator>
    </NavigationContainer>
  );
}
