class AltitudeWork < ApplicationRecord
  ALTITUDE_WORKS = ["Echafaudage", "Nacelles de Location", "Nacelles sur véhicule", "Nacelles négatives PL", "Autre"]
  has_many :selected_altitudes
end
