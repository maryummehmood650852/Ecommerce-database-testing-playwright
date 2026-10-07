import sql from 'mssql/msnodesqlv8';

export const dbConfig = {
  server: 'MARYUM-MEHMOOD',
  database: 'ECommerceDB',

  connectionTimeout: 5000,
  requestTimeout: 5000,

  options: {
    trustedConnection: true,
    trustServerCertificate: true
  }
};