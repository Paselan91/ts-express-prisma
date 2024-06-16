import express, { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

const app = express();
const prisma = new PrismaClient();
const port = 3000;

app.use(express.json());

app.get('/users', async (req: Request, res: Response) => {
  try {
    const users = await prisma.user.findMany();
    console.log(users)
    res.json(users);
  } catch (error) {
    console.log(error)
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.post('/users', async (req: Request, res: Response) => {
  try {
    const { name, age } = req.body;
    const user = await prisma.user.create({
      data: { name, age },
    });
    res.json(user);
  } catch (error) {
    console.log(error)
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});