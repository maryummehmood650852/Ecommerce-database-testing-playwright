import { execFile } from 'child_process';

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
      console.error('Database connection failed ❌');
      console.error(stderr || error.message);
      return;
    }

    console.log('Database connected successfully ✅');
    console.log(stdout);
  }
);