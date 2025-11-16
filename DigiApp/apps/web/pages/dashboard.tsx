import React, { useEffect } from 'react';
import { useRouter } from 'next/router';
import { useAuth } from '@digihealth/core';

export default function Dashboard() {
  const router = useRouter();
  const { role, setRoleForDemo } = useAuth();

  useEffect(() => {
    const r = (router.query.role as string) || role;
    if (r && setRoleForDemo) setRoleForDemo(r as any);
  }, [router.query.role, role, setRoleForDemo]);

  return (
    <main style={{ padding: 24 }}>
      <h2>Role (shared auth): {role}</h2>
      <p>This is a simple demo showing the same auth provider used in web and mobile (conceptually).</p>
    </main>
  );
}