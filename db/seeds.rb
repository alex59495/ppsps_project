# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create company
c = Company.create(name: "test company", address: "test company addres", representative: "company rep", phone: "0845454545", email: "company@gmail.com")
p "create #{c.id} company"

# Create users
users = [{
  email: "test1@gmail.com",
  password: "123456",
  admin: true
}, {
  email: "test2@gmail.com",
  password: "123456",
  admin: false
}]

users.each do |user|
  u = User.create(email: user[:email], password: user[:password], admin: user[:admin])
  p "create #{u.id} users"
end

# Create MOA
moa = {
  name: "Test MOA",
  address: "test address MOA",
  representative: "test representative MOA",
  phone: "0328261863",
  email: "alexis@gmail.com"
}

moa1 = Moa.create(name: moa[:name], address: moa[:address], representative: moa[:representative], phone: moa[:phone], email: moa[:email])
p "create #{moa1.id} moa"

# Create MOA
moe = {
  name: "Test MOE",
  address: "test address MOE",
  representative: "test representative MOE",
  phone: "0328261864",
  email: "alexiis@gmail.com"
}

moe1 = Moe.create(name: moe[:name], address: moe[:address], representative: moe[:representative], phone: moe[:phone], email: moe[:email])
p "create #{moe1.id} moe"

# Create Site Manager
site_manager = {
  name: "Test chef de chantier",
  phone: "0600000000",
  email: "chefdechantier@gmail.com"
}
site_manager1 = SiteManager.create(name: site_manager[:name], phone:site_manager[:phone], email:site_manager[:email])
p "create #{site_manager1.id} site manager"

# Create Team Manager
team_manager = {
  name: "Test chef d'équipe",
  phone: "0600000000",
  email: "chefdequipe@gmail.com"
}
team_manager1 = TeamManager.create(name: team_manager[:name], phone:team_manager[:phone], email:team_manager[:email])
p "create #{team_manager1.id} team manager"

# Create Project Informations
project_information = {
  reference: "AABB130",
  responsible: "Responsible Test",
  phone: "0300000000",
  email: "project@gmail.com",
  site_manager_id: 1,
  team_manager_id: 1
}
project_information1 = ProjectInformation.create(reference: project_information[:reference], phone:project_information[:phone],
responsible:project_information[:responsible], email:project_information[:email], site_manager_id:project_information[:site_manager_id],
team_manager_id:project_information[:team_manager_id])
p "create #{project_information1.id} project info"

# Create Sub Responsible
sub_responsible = {
  name: "responsable sous-traitant",
  phone: "0600000000",
  email: "sub_responsible@gmail.com"
}
sub_responsible1 = SubResponsible.create(name: sub_responsible[:name], phone: sub_responsible[:phone], email: sub_responsible[:email])
p "create #{sub_responsible1.id} sub responsible"

# Create Subcontractor
subcontractor = {
  name: "Sous Traitant",
  address: "address subcontract",
  work: "work subcontract",
  sub_responsible_id: 1,
}
subcontractor1 = Subcontractor.create(name: subcontractor[:name], address: subcontractor[:address], 
work: subcontractor[:work], sub_responsible_id: subcontractor[:sub_responsible_id])
p "create #{subcontractor1.id} subcontractor"

# Create DIRECCT
direcct = {
  address: "70 rue saint sauveur",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
}
r1 = Direcct.create(address: direcct[:address], phone: direcct[:phone], fax: direcct[:fax])
p "create #{r1.id} direcct"

# Create Regional Committee
regional_committee = {
  name:"Parc Europe",
  address:"340 avenue de la Marne",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
}
r2 = RegionalCommittee.create(address: regional_committee[:address], phone: regional_committee[:phone], 
fax: regional_committee[:fax], name: regional_committee[:name])
p "create #{r2.id} regional committee"

# Create Pension insurance
pension_insurance = {
  address:"11 allée Vauban",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
}
r3 = PensionInsurance.create(address: pension_insurance[:address], phone: pension_insurance[:phone], fax: pension_insurance[:fax])
p "create #{r3.id} pension insurance"


# Create Work Medecine
work_medecine = {
  address:"7 avenue du Général de Gaulle",
  phone:"03 03 03 03 03",
  fax:"03 03 03 03 03",
}
r4 = WorkMedecine.create(address: work_medecine[:address], phone: work_medecine[:phone], fax: work_medecine[:fax])
p "create #{r4.id} work medecine"

# Create demining
demining = Demining.create(name: "Deminage Arras", phone: "03 03 03 03 03", address: "Rue du déminage")
p "create #{demining.id} déminage"

# Create sos hands
sos_hand = SosHand.create(name: "Clinique Lille Sud", phone: "03 03 03 03 03", address: "Rue du Sos Mains")
p "create #{sos_hand.id} sos hand"

# Create sos hands
anti_poison = AntiPoison.create(name: "Clinique Lille Sud", phone: "03 03 03 03 03", address: "Rue du anti poison")
p "create #{anti_poison.id} anti poison"

# Create hospital
hospital = Hospital.create(name: "Hopital de Vervins", address: "Quelque part à Vervins", phone: "03 03 03 03 03")


# Create PPSP
ppsps = [{
  address: "test_1 address",
  start: DateTime.new(2020,9,1,17),
  end: DateTime.new(2020,9,1,19),
  nature: "test_1 nature",
  workforce: "test_1 workforce",
  agglomeration: "Agglomeration",
  street_impact: "Pas d'impact",
  river_guidance: "Cours d'eau",
  user_id: 1,
  company_id: 1,
  moa_id: 1,
  moe_id: 1,
  project_information_id: 1,
  subcontractor_id: 1,
  pension_insurance_id: 1,
  direcct_id: 1,
  work_medecine_id: 1,
  regional_committee_id: 1,
  demining_id: 1,
  sos_hand_id: 1,
  anti_poison_id: 1,
  hospital_id: 1,
}, {
  address: "test_2 address",
  start: DateTime.new(2020,9,1,17),
  end: DateTime.new(2020,9,1,19),
  nature: "test_2 nature",
  workforce: "test_2 workforce",
  agglomeration: "Agglomeration",
  street_impact: "Pas d'impact",
  river_guidance: "Cours d'eau",
  user_id: 1,
  company_id: 1,
  moa_id: 1,
  moe_id: 1,
  project_information_id: 1,
  pension_insurance_id: 1,
  direcct_id: 1,
  work_medecine_id: 1,
  regional_committee_id: 1,
  demining_id: 1,
  sos_hand_id: 1,
  anti_poison_id: 1,
  hospital_id: 1,
}, {
  address: "test_3 address",
  start: DateTime.new(2020,9,1,17),
  end: DateTime.new(2020,9,1,19),
  nature: "test_3 nature",
  workforce: "test_3 workforce",
  agglomeration: "Agglomeration",
  street_impact: "Pas d'impact",
  river_guidance: "Cours d'eau",
  user_id: 2,
  company_id: 1,
  moa_id: 1,
  moe_id: 1,
  project_information_id: 1,
  pension_insurance_id: 1,
  direcct_id: 1,
  work_medecine_id: 1,
  regional_committee_id: 1,
  demining_id: 1,
  sos_hand_id: 1,
  anti_poison_id: 1, 
  hospital_id: 1,
}]

ppsps.each do |ppsp|
  p = Ppsp.create(address: ppsp[:address], start: ppsp[:start], end: ppsp[:end], nature: ppsp[:nature], 
  workforce: ppsp[:workforce], user_id: ppsp[:user_id], company_id: ppsp[:company_id], moa_id: ppsp[:moa_id],
  moe_id: ppsp[:moe_id], project_information_id: ppsp[:project_information_id], agglomeration: ppsp[:agglomeration],
  street_impact: ppsp[:street_impact], river_guidance: ppsp[:river_guidance], subcontractor_id: ppsp[:subcontractor_id],
  pension_insurance_id: ppsp[:pension_insurance_id], direcct_id: ppsp[:direcct_id], work_medecine_id: ppsp[:work_medecine_id],
  regional_committee_id: ppsp[:regional_committee_id], demining_id: ppsp[:demining_id], 
  sos_hand_id: ppsp[:sos_hand_id], anti_poison_id: ppsp[:anti_poison_id], hospital_id: ppsp[:hospital_id],
  )
  p "create #{p.id} PPSP"
end

# Create site_installations
SiteInstallation::SITE_INSTALLATIONS.each do |site|
  s = SiteInstallation.create(name: site)
  p "Create #{s.id} site installations"
end
# Create altitude_works 
AltitudeWork::ALTITUDE_WORKS.each do |work|
  w = AltitudeWork.create(name: work)
  p "Create #{w.id} altitude works"
end
# Create risks
Risk::RISKS.each do |risk|
  r = Risk.create(name: risk)
  p "Create #{r.id} risks"
end
