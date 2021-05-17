# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all data ..."

Ppsp.destroy_all
Moe.destroy_all
Moa.destroy_all
Hospital.destroy_all
Demining.destroy_all
RegionalCommittee.destroy_all
RegionalCommittee.destroy_all
WorkMedecine.destroy_all
Risk.destroy_all
SecurityCoordinator.destroy_all
SiteInstallation.destroy_all
SosHand.destroy_all
Direcct.destroy_all
AntiPoison.destroy_all
AltitudeWork.destroy_all
PensionInsurance.destroy_all
Conductor.destroy_all
Machine.destroy_all
MachineCategory.destroy_all
Worker.destroy_all
User.destroy_all
Subcontractor.destroy_all
Company.destroy_all

# Create company
c1 = Company.create!(name: "Company Angelique", address: 'Test adress', phone: '0300000000', representative: 'Chef de Company Angelique')
p "create #{c1.id} company"
c2 = Company.create!(name: Faker::Company.name, address: Faker::Address.street_address, phone: Faker::PhoneNumber.cell_phone_in_e164, representative: Faker::Name.name )
p "create #{c2.id} company"
c3 = Company.create!(name: Faker::Company.name, address: Faker::Address.street_address, phone: Faker::PhoneNumber.cell_phone_in_e164, representative: Faker::Name.name )
p "create #{c3.id} company"


(1..11).each do |n|
  kit_security_element = KitSecurityElement.create!(name: "Bandellete de protection n*#{n}", number: rand(1..11), company: c1)
  p "Create #{kit_security_element.id} Security kit for #{c1.name}"
end

# Create users
users = [{
  first_name: "Angelique",
  last_name: "Lenoir",
  email: "test1@gmail.com",
  password: "@leX1s",
  admin: true,
  company: c1,
}, {
  first_name: "Jean",
  last_name: "Michel",
  email: "test2@gmail.com",
  password: "@leX1s",
  admin: false,
  company: c1,
},
{
  first_name: "Luc",
  last_name: "Beaumont",
  email: "test3@gmail.com",
  password: "@leX1s",
  admin: false,
  company: c2,
},{
  first_name: "Jean",
  last_name: "Castex",
  email: "test4@gmail.com",
  password: "@leX1s",
  admin: false,
  company: c3,
}]

users.each do |user|
  u = User.create!(email: user[:email], password: user[:password], admin: user[:admin], 
  company: user[:company], first_name: user[:first_name], last_name: user[:last_name])
  p "create #{u.id} users"
end

# Create MOA
CSV.foreach('./Database_MOA.csv', headers: true, encoding:'utf-8', col_sep: ";") do |row|
  # Create a hash for each MOA with the header of the CSV file
  moa = row.to_h  
  m = Moa.create(
    name: moa["Maitre Ouvrage"], 
    address: moa['Adresse'],
    representative: moa['Nom du representant'],
    phone: moa['Telephone'],
    email: moa['Mail'],
    company: Company.find_by(name: moa['Entreprise'])
    )
  p "Create #{m.id} MOA"
end

# Create MOE
CSV.foreach('./Database_MOE.csv', headers: true, encoding:'utf-8', col_sep: ";") do |row|
  # Create a hash for each MOE with the header of the CSV file
  moe = row.to_h
  mo = Moe.create(
    name: moe["Maitre Oeuvre"], 
    address: moe['Adresse'],
    representative: moe['Nom du representant'],
    phone: moe['Telephone'],
    email: moe['Mail'],
    company: Company.find_by(name: moe['Entreprise'])
    )
  p "Create #{mo.id} MOE"
end

# Create workers
100.times do
  worker = Worker.create!(
    first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    lifesaver: [true, false].sample, 
    conductor: [true, false].sample, 
    role: Worker::ROLE.sample,
    company: Company.all.sample,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone_in_e164)
  p "Create #{worker.id} worker"
end

# Create DIRECCT
direcct = {
  address: "70 rue saint sauveur",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
  company: Company.first
}
r1 = Direcct.create(address: direcct[:address], phone: direcct[:phone], fax: direcct[:fax], company:direcct[:company])
p "create #{r1.id} direcct"

# Create Regional Committee
regional_committee = {
  name:"Parc Europe",
  address:"340 avenue de la Marne",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
  company: Company.first
}
r2 = RegionalCommittee.create(address: regional_committee[:address], phone: regional_committee[:phone], 
fax: regional_committee[:fax], name: regional_committee[:name], company:regional_committee[:company])
p "create #{r2.id} regional committee"

# Create Pension insurance
pension_insurance = {
  address:"11 allée Vauban",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
  company: Company.first
}
r3 = PensionInsurance.create(address: pension_insurance[:address], phone: pension_insurance[:phone], fax: pension_insurance[:fax],
company:pension_insurance[:company])
p "create #{r3.id} pension insurance"


# Create Work Medecine
work_medecine = {
  address:"7 avenue du Général de Gaulle",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
  company: Company.first
}
r4 = WorkMedecine.create(address: work_medecine[:address], phone: work_medecine[:phone], fax: work_medecine[:fax], company:work_medecine[:company])
p "create #{r4.id} work medecine"

# Create demining
demining = Demining.create(name: "Deminage Arras", phone: "03 03 03 03 03", address: "Rue du déminage", company: Company.first)
p "create #{demining.id} déminage"

# Create sos hands
sos_hand = SosHand.create(name: "Clinique Lille Sud", phone: "03 03 03 03 03", address: "Rue du Sos Mains", company: Company.first)
p "create #{sos_hand.id} sos hand"

# Create sos hands
anti_poison = AntiPoison.create(name: "Clinique Lille Sud", phone: "03 03 03 03 03", address: "Rue du anti poison", company: Company.first)
p "create #{anti_poison.id} anti poison"

# Create hospitals
CSV.foreach('./Database_hospitals.csv', headers: true, encoding:'iso-8859-1:utf-8', col_sep: ";") do |row|
  # Create a hash for each hospital with the header of the CSV file
  hospital = row.to_h
  h = Hospital.create(
    name: hospital['Nom'], 
    address: "#{hospital['Adresse']}, #{hospital['Ville']}, #{hospital['Code postal']}",
    phone: hospital['Telephone'],
    company: Company.find_by(name: hospital['Entreprise'])
    )
  p "Create #{h.id} hospital"
end

# Create security coordinators
CSV.foreach('./Database_security_coordinators.csv', headers: true, encoding:'iso-8859-1:utf-8', col_sep: ";") do |row|
  # Create a hash for each hospital with the header of the CSV file
  security_coordinator = row.to_h
  sc = SecurityCoordinator.create(
    name: security_coordinator['Coordonnateur'], 
    address: security_coordinator['Adresse'],
    phone: security_coordinator['Telephone'],
    email: security_coordinator['Mail'],
    representative: security_coordinator['Nom du representant'],
    company: Company.find_by(name: security_coordinator['Entreprise'])
    )
  p "Create #{sc.id} security coordinators"
end

# Create PPSP
ppsps = []
100.times do |n|
  company = Company.all.sample
  summer = [true, false].sample
  winter = [true, false].sample
  p = Ppsp.create!(
    user: User.where(company: company).sample,
    moa: Moa.all.sample,
    moe: Moe.all.sample,
    pension_insurance: PensionInsurance.all.sample,
    direcct: Direcct.all.sample,
    work_medecine: WorkMedecine.all.sample,
    regional_committee: RegionalCommittee.all.sample,
    security_coordinator: SecurityCoordinator.all.sample,
    demining: Demining.all.sample,
    sos_hand: SosHand.all.sample,
    anti_poison: AntiPoison.all.sample,
    hospital: Hospital.all.sample,
    reference: "AABB1#{n+10}",
    company: company,
    name: "Ceci est la désignation du chantier #{n}",
    responsible: Worker.where(company: company, role: 'Conducteur de travaux').sample,
    site_manager: Worker.where(company: company, role: 'Chef de chantier').sample,
    team_manager: Worker.where(company: company, role: "Chef d'équipe").sample,
    address: Faker::Address.street_address, 
    start_date: DateTime.new(2020,9,1,17),
    end_date: DateTime.new(2020,9,10,19), 
    nature: "test_#{n+1} nature", 
    num_responsible: rand(0..10), 
    num_conductor: rand(0..10), 
    num_worker: rand(0..10), 
    timetable_summer: summer,
    timetable_summer_start: summer ? '8h' : nil,
    timetable_summer_end: summer ? '16h30' : nil,
    timetable_summer_start_friday: summer ? '8h' : nil,
    timetable_summer_end_friday: summer ? '16h00' : nil,
    timetable_winter: winter,
    timetable_winter_start: winter ? '9h' : nil,
    timetable_winter_end: winter ? '17h30' : nil,
    timetable_winter_start_friday: winter ? '9h' : nil,
    timetable_winter_end_friday: winter ? '17h30' : nil,
    electrical_site: [true, false].sample, 
    water_site: [true, false].sample, 
    plan: false
  )
  p "create #{p.id} PPSP"
end

# Create Subcontractor
subcontractors = []
30.times do |n|
  subcontractor = {
    name: "Sous Traitant #{n}",
    address: "address subcontract #{n}",
    work: "work subcontract #{n}",
    responsible_name: Faker::Name.name,
    responsible_phone: "03 28 26 18 63",
    responsible_email: "alexis@gmail.com",
    company_id: Company.all.sample.id
  }
  subcontractors.append(subcontractor)
end

subcontractors.each do |subcontractor|
  subcontractor = Subcontractor.create(name: subcontractor[:name], address: subcontractor[:address], 
  work: subcontractor[:work], responsible_name: subcontractor[:responsible_name], responsible_phone: subcontractor[:responsible_phone],
  responsible_email: subcontractor[:responsible_email], company_id: subcontractor[:company_id])
  p "create #{subcontractor.id} subcontractor"
end

# Create site_installations
SiteInstallation::SITE_INSTALLATIONS.each do |site|
  s = SiteInstallation.create(name: site[:name], mobile: site[:mobile])
  p "Create #{s.id} site installations"
end
# Create altitude_works 
AltitudeWork::ALTITUDE_WORKS.each do |work|
  w = AltitudeWork.create(name: work)
  p "Create #{w.id} altitude works"
end

# Create Risk types
RiskType::RISK_TYPES.each do |type|
  t = RiskType.create(name: type)
  p "Create #{t.id} type de risques"
end

# Create risks
Risk::RISKS.each do |risk|
  r = Risk.create(name: risk[:name], risk_type_id: risk[:type_id], file: risk[:file])
  p "Create #{r.id} risks"
end

MachineCategory::MACHINE_CATEGORIES.each do |category|
  c = MachineCategory.create!(name: category)
  p "Create #{c.id} types de machines"
end

# Create Machines
Machine::MACHINES.each do |machine|
  m = Machine.create!(
    caces: machine[:caces],
    # Get the name from the MachineCategory::MACHINE_CATEGORIE array
    machine_category: MachineCategory.find_by(name: MachineCategory::MACHINE_CATEGORIES[machine[:categorie]]),
    description: machine[:description], 
    image: machine[:image])
  p "Create #{m.id} machines"
end
