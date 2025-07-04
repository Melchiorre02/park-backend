import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  // Dati attrazioni
  const attractions = [
    {
      name: "Montagne Russe Extreme",
      description: "Un'esperienza adrenalinica con giri della morte e discese ripide",
      category: "avventura",
      waitTime: 45,
      ageRestriction: "8+",
      intensity: 5,
      zone: "Zona Avventura",
      rating: 4.8,
      popularity: 95,
      views: 1250,
      likes: 892,
      status: "open",
      image: "/img/montagna-russa-ex.jpg",
    },
    {
      name: "Splash Mountain",
      description: "Discesa acquatica con un tuffo finale di 15 metri",
      category: "acqua",
      waitTime: 30,
      ageRestriction: "6+",
      intensity: 4,
      zone: "Zona Acqua",
      rating: 4.6,
      popularity: 88,
      views: 980,
      likes: 654,
      status: "open",
      image: "/img/montagne-russe-splash.jpg",
    },
    {
      name: "Torre del Terrore",
      description: "Ascensore che precipita da 50 metri di altezza",
      category: "horror",
      waitTime: 60,
      ageRestriction: "12+",
      intensity: 5,
      zone: "Zona Horror",
      rating: 4.9,
      popularity: 92,
      views: 1450,
      likes: 1023,
      status: "open",
      image: "/img/torre.jpg",
    },
    {
      name: "Giostra Incantata",
      description: "Giostra tradizionale per tutta la famiglia",
      category: "famiglia",
      waitTime: 10,
      ageRestriction: "Tutti",
      intensity: 1,
      zone: "Zona Famiglia",
      rating: 4.3,
      popularity: 75,
      views: 650,
      likes: 432,
      status: "open",
      image: "/img/incantate.png",
    },
    {
      name: "Volo dell'Aquila",
      description: "Simulatore di volo sopra paesaggi mozzafiato",
      category: "avventura",
      waitTime: 25,
      ageRestriction: "8+",
      intensity: 3,
      zone: "Zona Avventura",
      rating: 4.5,
      popularity: 82,
      views: 890,
      likes: 567,
      status: "open",
      image: "/img/acquila.jpg",
    },
  ]

  for (const attr of attractions) {
    await prisma.attraction.upsert({
      where: { name: attr.name },
      update: {},
      create: attr,
    })
  }

  // Dati spettacoli
  const shows = [
    {
      name: "Spettacolo di Magia",
      description: "Spettacolo di magia con illusioni incredibili e effetti speciali",
      category: "Magia",
      times: "14:30",
      day: "oggi",
      duration: 45,
      location: "Teatro Principale",
      capacity: 500,
      image: "/img/magia.png",
      rating: 4.8,
      popularity: 95,
      status: "available",
      nextShow: "14:30",
      likes: 1247,
      views: 8934,
    },
    {
      name: "Parata dei Personaggi Disney",
      description: "Tutti i tuoi personaggi Disney preferiti in una parata magica",
      category: "Parata",
      times: "16:00",
      day: "domani",
      duration: 30,
      location: "Via Principale",
      capacity: 1000,
      image: "/img/personaggi.jpg",
      rating: 4.9,
      popularity: 98,
      status: "available",
      nextShow: "16:00",
      likes: 2156,
      views: 12453,
    },
    {
      name: "Spettacolo di Acrobazie Aeree",
      description: "Acrobazie mozzafiato che sfidano la gravità",
      category: "Acrobatico",
      times: "15:15",
      day: "oggi",
      duration: 25,
      location: "Arena Centrale",
      capacity: 300,
      image: "/img/acrobati.jpg",
      rating: 4.7,
      popularity: 87,
      status: "available",
      nextShow: "15:15",
      likes: 892,
      views: 5621,
    },
    {
      name: "Spettacolo con Delfini",
      description: "Spettacolo con delfini che mostrano abilità incredibili e trucchi",
      category: "Animali",
      times: "17:30",
      day: "oggi",
      duration: 40,
      location: "Teatro della Magia",
      capacity: 200,
      image: "/img/delfini.jpg",
      rating: 4.6,
      popularity: 82,
      status: "available",
      nextShow: "17:30",
      likes: 743,
      views: 4287,
    },
    {
      name: "Fuochi d'Artificio",
      description: "Spettacolo di fuochi d'artificio con musica e luci",
      category: "Acrobatico",
      times: "13:00",
      day: "domani",
      duration: 35,
      location: "Area Safari",
      capacity: 400,
      image: "/img/fuochi.jpg",
      rating: 4.5,
      popularity: 79,
      status: "maintenance",
      nextShow: "Manutenzione",
      likes: 634,
      views: 3892,
    },
  ]

  for (const show of shows) {
    await prisma.show.upsert({
      where: { name: show.name },
      update: {},
      create: show,
    })
  }

  // Mappa attrazioni
  const attractionMap = [
    {
      x: 20, y: 20, name: "Montagne Russe Extreme", waitTime: 45, type: "attraction",
      description: "Un'esperienza adrenalinica mozzafiato...",
      zone: "Zona Avventura", duration: "3 minuti", height: "140 cm minimo",
      intensity: "Estrema", rating: 4.8, reviews: 1247, openTime: "09:00 - 22:00",
      fastPass: true, image: "/img/montagna-russa-ex.jpg"
    },
    {
      x: 30, y: 60, name: "Splash Mountain", waitTime: 30, type: "attraction",
      description: "Discesa acquatica spettacolare...",
      zone: "Zona Acqua", duration: "8 minuti", height: "120 cm minimo",
      intensity: "Media", rating: 4.6, reviews: 892, openTime: "10:00 - 21:00",
      fastPass: true, image: "/img/montagne-russe-splash.jpg"
    },
    {
      x: 70, y: 25, name: "Torre del Terrore", waitTime: 60, type: "attraction",
      description: "Ascensore che precipita da 50 metri...",
      zone: "Zona Horror", duration: "5 minuti", height: "130 cm minimo",
      intensity: "Estrema", rating: 4.9, reviews: 2156, openTime: "11:00 - 23:00",
      fastPass: true, image: "/img/torre.jpg"
    },
    {
      x: 80, y: 70, name: "Giostra Incantata", waitTime: 10, type: "attraction",
      description: "Giostra tradizionale magica...",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.3, reviews: 567, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/incantate.png"
    },
    {
      x: 30, y: 30, name: "Volo dell'Aquila", waitTime: 25, type: "attraction",
      description: "Simulatore di volo sopra paesaggi mozzafiato",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.1, reviews: 327, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/acquila.jpg"
    },
  ]

  for (const attr of attractionMap) {
    await prisma.attractionMap.upsert({
      where: { name: attr.name },
      update: {},
      create: attr,
    })
  }

  // Mappa spettacoli
  const showMap = [
    {
      x: 30, y: 30, name: "Spettacolo di Magia", waitTime: 25, type: "shows",
      description: "Spettacolo di magia con illusioni incredibili...",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.2, reviews: 965, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/magia.png"
    },
    {
      x: 45, y: 70, name: "Parata dei Personaggi Disney", waitTime: 25, type: "shows",
      description: "Parata con i personaggi Disney preferiti",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.7, reviews: 767, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/personaggi.jpg"
    },
    {
      x: 60, y: 80, name: "Spettacolo di Acrobazie Aeree", waitTime: 25, type: "shows",
      description: "Acrobazie mozzafiato che sfidano la gravità",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.9, reviews: 865, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/acrobati.jpg"
    },
    {
      x: 15, y: 60, name: "Fuochi d'Artificio", waitTime: 25, type: "shows",
      description: "Spettacolo di fuochi d'artificio con musica e luci",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.7, reviews: 457, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/fuochi.jpg"
    },
    {
      x: 60, y: 40, name: "Spettacolo con Delfini", waitTime: 25, type: "shows",
      description: "Spettacolo con delfini intelligenti e divertenti",
      zone: "Zona Famiglia", duration: "4 minuti", height: "Nessun limite",
      intensity: "Bassa", rating: 4.6, reviews: 274, openTime: "09:00 - 22:00",
      fastPass: false, image: "/img/delfini.jpg"
    },
  ]

  for (const show of showMap) {
    await prisma.showMap.upsert({
      where: { name: show.name },
      update: {},
      create: show,
    })
  }
}

main()
  .catch(e => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
