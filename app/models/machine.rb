class Machine < ApplicationRecord
  belongs_to :machine_category
  has_many :conductors
  has_many :workers, through: :conductors
  validates :caces, presence: true
  validates :machine_category, presence: true
  validates :description, presence: true
  validates :image, presence: true

  MACHINES = [
    # Engins de chantier
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie A',
      description: 'Pelles hydrauliques à chenilles ou sur pneumatiques de masse ≤ 6 tonnes, chargeuses à  chenilles ou sur  pneumatiques de masse ≤ 6 tonnes, chargeuses-pelleteuses de masse ≤ 6 tonnes, moto-basculeurs de masse ≤ 6 tonnes, compacteurs de masse ≤ 6 tonnes, tracteurs agricoles de puissance ≤ 100 cv (73,6 kW)',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie B1',
      description: 'Engins d’extraction à déplacement séquentiel : pelles hydrauliques, à chenilles ou sur pneumatiques de masse > 6 tonnes, pelles multifonctions',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie B2',
      description: 'Engins de sondage ou de forage à déplacement séquentiel : machines automotrices de sondage ou de forage',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie B3',
      description: 'Engins rail-route à déplacement séquentiel : pelle hydraulique Rail Route',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie C1',
      description: 'Engins de chargement à déplacement alternatif : Chargeuses sur pneumatique de masse > 6 tonnes, chargeuses-pelleteuses de masse > 6 tonnes',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie C2',
      description: 'Engins de réglage à déplacement alternatif : bouteurs, chargeuses à chenilles de masse > 6 tonnes.',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie C3',
      description: 'Engins de nivellement à déplacement alternatif : niveleuses automotrices.',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie D',
      description: 'Engins de compactage : compacteurs, à cylindres, à pneumatiques ou mixtes, de masse > 6 tonnes, compacteurs à pieds dameurs de masse > 6 tonnes',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie E',
      description: 'Engins de transport : tombereaux, rigides ou articulés, moto-basculeurs de masse > 6 tonnes, tracteurs  agricoles  de  puissance  >  100  cv  (73,6 kW)',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie F',
      description: 'Chariots de manutention tout terrain : chariots de manutention tout-terrain à conducteur porté/à mât, chariots de manutention tout-terrain à conducteur porté, à flèche télescopique',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 0,
      caces: 'Catégorie G',
      description: "Conduite d'engins hors production : déplacement et chargement / déchargement sur porte-engins des engins de chantier des catégories A à F, sans activité de production, pour démonstration ou essais",
      image: 'machines/test_engin_chantier.jpg'
    },
    # Grues mobiles
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 1,
      caces: 'Catégorie A',
      description: "Grue automotrice à flèche treillis  qui  peut  être  montée sur un mât (tour), capable de se déplacer en charge ou à vide sans avoir besoin de voie de roulement fixe et qui demeure stable sous l'influence de la gravité",
      image: 'machines/test_engin_chantier_2.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 1,
      caces: 'Catégorie B',
      description: "Grue  automotrice à flèche télescopique qui peut être montée sur un mât (tour), capable de se déplacer en charge ou à vide sans avoir besoin de voie de roulement fixe et qui demeure stable sous l'influence de la gravité",
      image: 'machines/test_engin_chantier_2.jpg'
    },
    # Ponts roulants et portiques
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 2,
      caces: 'Catégorie 1',
      description: "Pont roulant à commande au sol",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 2,
      caces: 'Catégorie 2',
      description: "Pont roulant et portiques à commande en cabine",
      image: 'machines/test_pont_roulant.jpg'
    },
    # Gerbeur à conducteur accompagnant
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 3,
      caces: 'Catégorie 1',
      description: "Gerbeurs automoteurs à conducteur accompagnant (hauteur de levée comprise entre 1,2à m et 2,50 m)",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 3,
      caces: 'Catégorie 2',
      description: "Gerbeurs automoteurs à conducteur accompagnant (hauteur de levée supérieure à 2,50 m) ",
      image: 'machines/test_pont_roulant.jpg'
    },
    # Nacelles / PEMP (plateformes élévatrices mobiles de personnel)
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 4,
      caces: 'Catégorie A',
      description: "Nacelles verticales de type 1 et type 3 ",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 4,
      caces: 'Catégorie B',
      description: "Nacelles à élévation multidirectionnelle de type 1 et type 3 ",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 4,
      caces: 'Catégorie C',
      description: "Conduite hors production des PEMP des catégories A ou B : déplacement, chargement/ déchargement sur portes engins, transferts sans activité de production pour maintenance, démonstrations ou pour essais",
      image: 'machines/test_pont_roulant.jpg'
    },
    # Grues à tour
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 5,
      caces: 'Catégorie 1',
      description: "Grues à tour à montage par éléments, à flèche distributrice",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 5,
      caces: 'Catégorie 2',
      description: "Grues à tour à montage par éléments, à flèche relevable ",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 5,
      caces: 'Catégorie 3',
      description: "Grues à tour à montage automatisé ",
      image: 'machines/test_pont_roulant.jpg'
    },
    # Chariots de manutention à conducteur porté
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 1A',
      description: "Transpalettes à conducteur porté et préparateur de commandes au sol (levée ≤1,2m)",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 1B',
      description: "Gerbeurs à conducteur porté",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 2A',
      description: "Chariots à plateau porteur de capacité de charge inférieure ou égale à 2 tonnes",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie',
      description: "Chariots tracteurs industriels capacité de traction inférieure ou égale à 25 tonnes",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 3',
      description: "Chariots élévateurs en porte-à-faux de capacité inférieure ou égale à 6000 kg",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 4',
      description: "Chariot élévateurs en porte-à-faux de capacité supérieure à 6000 kg",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 5',
      description: "Chariots élévateurs à mât rétractable",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 6',
      description: "Chariots élévateurs à poste de conduite élevable (hauteur de plancher supérieure ou égale à 1,20m)",
      image: 'machines/test_pont_roulant.jpg'
    },
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 6,
      caces: 'Catégorie 7',
      description: "Conduite de chariots hors production : maintenance, entretien, livraison et transport",
      image: 'machines/test_pont_roulant.jpg'
    },
    # Grues de chargement
    {
      # Référence à l'index du tableau MachineCategory::MACHINE_CATEGORIES
      categorie: 7,
      caces: 'Catégorie R490',
      description: "Grue de déchargement montée derrière la cabine, Grue de chargement montée en porte à faux arrière, grue de chargement montée en position centrale ",
      image: 'machines/test_pont_roulant.jpg'
    },
  ]
end
