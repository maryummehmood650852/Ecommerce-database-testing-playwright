import { test, expect } from '@playwright/test';
import { execFile } from 'child_process';

const isCI = process.env.CI === 'true';

const sqlServer = isCI ? 'localhost,1433' : 'MARYUM-MEHMOOD';
const database = 'ECommerceDB';

function runSql(query: string): Promise<string> {
  return new Promise((resolve, reject) => {
    const args = isCI
      ? [
          '-S', sqlServer,
          '-d', database,
          '-U', process.env.DB_USER || 'sa',
          '-P', process.env.DB_PASSWORD || '',
          '-C',
          '-Q', query,
          '-l', '5'
        ]
      : [
          '-S', sqlServer,
          '-d', database,
          '-E',
          '-Q', query,
          '-l', '5'
        ];

    execFile(
      'sqlcmd',
      args,
      { timeout: 15000 },
      (error, stdout, stderr) => {
        if (error) {
          reject(new Error(stderr || error.message));
        } else {
          resolve(stdout);
        }
      }
    );
  });
}

test('Verify customer count in database', async () => {
  const output = await runSql(
    'SELECT COUNT(*) AS CustomerCount FROM Customers'
  );

  console.log(output);

  expect(output).toContain('CustomerCount');
});

test('Verify products have valid prices', async () => {
  const output = await runSql(
    'SELECT COUNT(*) AS InvalidProducts FROM Products WHERE Price <= 0'
  );

  console.log(output);

  expect(output).toContain('InvalidProducts');
  expect(output).toContain('0');
});

test('Verify all orders belong to valid customers', async () => {
  const output = await runSql(`
    SELECT COUNT(*) AS InvalidOrders
    FROM Orders o
    LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE c.CustomerID IS NULL
  `);

  console.log(output);

  expect(output).toContain('InvalidOrders');
  expect(output).toContain('0');
});