import express from 'express'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'
import prisma from '../prisma/prisma/prismaclient.js'
import { verifyToken } from '../middleware/verifyToken.js'

const router = express.Router()

// 🔐 LOGIN
router.post('/login', async (req, res) => {
  const { email, password } = req.body

  if (!email || !password) {
    return res.status(400).json({ message: 'Email e password sono obbligatorie' })
  }

  try {
    const user = await prisma.user.findUnique({ where: { email } })
    if (!user) {
      return res.status(401).json({ message: 'Credenziali non valide' })
    }

    const passwordMatch = await bcrypt.compare(password, user.password)
    if (!passwordMatch) {
      return res.status(401).json({ message: 'Credenziali non valide' })
    }

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1d' })

    res.status(200).json({
      message: 'Login effettuato con successo',
      user,
      token,
    })
  } catch (error) {
    console.error('Errore durante il login:', error)
    res.status(500).json({ message: 'Errore durante il login' })
  }
})

// 📝 REGISTRAZIONE
router.post('/register', async (req, res) => {
  const { name, email, password, confermaPassword } = req.body

  console.log("Dati registrazione:", { name, email, password, confermaPassword })

  if (!name || !email || !password || !confermaPassword) {
    console.log("Errore campi mancanti:", { name, email, password, confermaPassword })
    return res.status(400).json({ message: 'Tutti i campi sono obbligatori' })
  }

  if (password !== confermaPassword) {
    return res.status(400).json({ message: 'Le password non corrispondono' })
  }

  try {
    const userExist = await prisma.user.findUnique({ where: { email } })
    if (userExist) {
      return res.status(400).json({ message: 'Email già registrata' })
    }

    const hashedPassword = await bcrypt.hash(password, 10)

    const user = await prisma.user.create({
      data: {
        name,
        email,
        password: hashedPassword,
      },
    })

    console.log("Utente creato:", user)

    res.status(201).json({ message: 'Utente registrato con successo', user })
  } catch (error) {
    console.error('Errore registrazione:', error)
    res.status(500).json({ message: 'Errore durante la registrazione' })
  }
})

// 🔄 CAMBIO PASSWORD (protetto)
router.post('/update-password', verifyToken, async (req, res) => {
  const { currentPassword, newPassword } = req.body
  const userId = req.user.id

  try {
    const user = await prisma.user.findUnique({ where: { id: userId } })

    const passwordMatch = await bcrypt.compare(currentPassword, user.password)
    if (!passwordMatch) {
      return res.status(400).json({ message: 'La password attuale è errata' })
    }

    const hashedPassword = await bcrypt.hash(newPassword, 10)
    await prisma.user.update({
      where: { id: userId },
      data: { password: hashedPassword },
    })

    res.json({ message: 'Password aggiornata con successo' })
  } catch (error) {
    console.error("Errore durante l'aggiornamento della password:", error)
    res.status(500).json({ message: 'Errore del server' })
  }
})

export default router
