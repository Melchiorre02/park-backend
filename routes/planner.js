import express from 'express'
import prisma from '../prisma/prisma/prismaclient.js'

const router = express.Router()

// ✅ Salva o aggiorna planner per utente e data
router.post('/save', async (req, res) => {
  const { name, date, items, userId } = req.body

  if (!name || !date || !items || !userId) {
    return res.status(400).json({ message: "Dati mancanti" })
  }

  try {
    const userExists = await prisma.user.findUnique({
      where: { id: userId }
    })

    if (!userExists) {
      return res.status(404).json({ message: "Utente non trovato" })
    }

    const existingPlanner = await prisma.planner.findFirst({
      where: {
        userId,
        date,
      },
    })

    const planner = existingPlanner
      ? await prisma.planner.update({
          where: { id: existingPlanner.id },
          data: { name, items },
        })
      : await prisma.planner.create({
          data: { name, date, items, userId },
        })

    res.status(200).json({ message: "Planner salvato", planner })
  } catch (error) {
    console.error("Errore planner:", error)
    res.status(500).json({ message: "Errore durante il salvataggio" })
  }
})

// ✅ Elimina planner tramite ID
router.delete('/delete/:id', async (req, res) => {
  const { id } = req.params

  if (!id) {
    return res.status(400).json({ message: "ID mancante" })
  }

  try {
    const planner = await prisma.planner.findUnique({
      where: { id },
    })

    if (!planner) {
      return res.status(404).json({ message: "Planner non trovato" })
    }

    await prisma.planner.delete({
      where: { id },
    })

    res.status(200).json({ message: "Planner eliminato con successo" })
  } catch (error) {
    console.error("Errore durante l'eliminazione del planner:", error)
    res.status(500).json({ message: "Errore del server durante l'eliminazione" })
  }
})

// ✅ Recupera planner più recente per un utente
router.get('/user/:userId', async (req, res) => {
  const { userId } = req.params

  if (!userId) {
    return res.status(400).json({ message: "userId mancante" })
  }

  try {
    const planner = await prisma.planner.findFirst({
      where: { userId },
      orderBy: { createdAt: 'desc' },
    })

    if (!planner) {
      return res.status(404).json({ message: 'Nessun planner trovato' })
    }

    res.status(200).json({ planner })
  } catch (error) {
    console.error('Errore nel recupero del planner:', error)
    res.status(500).json({ message: 'Errore del server' })
  }
})

export default router
