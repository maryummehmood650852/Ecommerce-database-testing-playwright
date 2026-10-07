import { test, expect } from '@playwright/test';
import { execFile } from 'child_process';

test('Verify customer count in database', async () => {
  const output = await new Promise<string>((resolve, reject) => {
    execFile(
      'sqlcmd',
      [
        '-S', 'MARYUM-MEHMOOD',
        '-d', 'ECommerceDB',
        '-E',
        '-Q', 'SELECT COUNT(*) AS CustomerCount FROM Customers',
        '-l', '5'
      ],
      { timeout: 7000 },
      (error, stdout, stderr) => {
        if (error) {
          reject(new Error(stderr || error.message));
        } else {
          resolve(stdout);
        }
      }
    );
  });

  console.log(output);

  expect(output).toContain('CustomerCount');
});
test('Verify products have valid prices', async () => {
  const output = await new Promise<string>((resolve, reject) => {
    execFile(
      'sqlcmd',
      [
        '-S', 'MARYUM-MEHMOOD',
        '-d', 'ECommerceDB',
        '-E',
        '-Q', 'SELECT COUNT(*) AS InvalidProducts FROM Products WHERE Price <= 0',
        '-l', '5'
      ],
      { timeout: 7000 },
      (error, stdout, stderr) => {
        if (error) {
          reject(new Error(stderr || error.message));
        } else {
          resolve(stdout);
        }
      }
    );
  });

  console.log(output);

  expect(output).toContain('InvalidProducts');
  expect(output).toContain('0');
});
test('Verify all orders belong to valid customers', async () => {
  const output = await new Promise<string>((resolve, reject) => {
    execFile(
      'sqlcmd',
      [
        '-S', 'MARYUM-MEHMOOD',
        '-d', 'ECommerceDB',
        '-E',
        '-Q', `
          SELECT COUNT(*) AS InvalidOrders
          FROM Orders o
          LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
          WHERE c.CustomerID IS NULL
        `,
        '-l', '5'
      ],
      { timeout: 7000 },
      (error, stdout, stderr) => {
        if (error) {
          reject(new Error(stderr || error.message));
        } else {
          resolve(stdout);
        }
      }
    );
  });

  console.log(output);

  expect(output).toContain('InvalidOrders');
  expect(output).toContain('0');
});