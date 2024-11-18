import http from 'http';
import PG from 'pg';
import { createProxyMiddleware } from 'http-proxy-middleware';

const port = Number(process.env.PORT || 3000);  // Establece el puerto correctamente

const client = new PG.Client(
  `postgres://${process.env.DB_USER}:${process.env.DB_PASS}@${process.env.DB_HOST}:${process.env.DB_PORT || 5432}/${process.env.DB_NAME}`
);

let successfulConnection = false;

// Proxy para redirigir solicitudes
const handleProxy = (req, res) => {
  const proxy = createProxyMiddleware({
    target: 'http://localhost:3000',  // Dirección del backend
    changeOrigin: true,
    pathRewrite: { '^/api': '' },  // Elimina /api del prefijo
  });

  proxy(req, res); // Aplica el proxy a la solicitud
};

http.createServer(async (req, res) => {
  console.log(`Request: ${req.url}`);

  // Habilitar proxy solo para las rutas que empiezan con /api
  if (req.url.startsWith("/api")) {
    handleProxy(req, res); // Redirige la solicitud al backend
  } else if (req.url === "/") {
    res.writeHead(200);
    res.end("Backend is running");
  } else {
    res.writeHead(503);
    res.end("Service Unavailable");
  }
}).listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});

