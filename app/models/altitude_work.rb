class AltitudeWork < ApplicationRecord
  ALTITUDE_WORKS = ["Echafaudage", "Nacelles de Location", "Nacelles sur véhicule", "Nacelles négatives PL"]
  has_many :selected_altitudes
end
