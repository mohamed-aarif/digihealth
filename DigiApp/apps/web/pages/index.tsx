import React from 'react';
import Link from 'next/link';
export default function Home() {
  return (
    <main style={{ padding: 24 }}>
      <h1>DigiHealth — Web</h1>
      <p>Welcome. Use the demo links below.</p>
      <ul>
        <li><Link href='/dashboard?role=PATIENT'>Patient dashboard</Link></li>
        <li><Link href='/dashboard?role=DOCTOR'>Doctor workspace</Link></li>
        <li><Link href='/dashboard?role=FAMILY'>Family dashboard</Link></li>
      </ul>
    </main>
  );
}
