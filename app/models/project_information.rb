class ProjectInformation < ApplicationRecord
  has_many :ppsps, inverse_of: :project_information
  belongs_to :responsible, class_name: "Worker"
  belongs_to :team_manager, class_name: "Worker"
  belongs_to :site_manager, class_name: "Worker"
  belongs_to :company
  validates :reference, presence: true
  validates :name, presence: true
  validates :responsible_id, presence: true
  validates :team_manager_id, presence: true
  validates :site_manager_id, presence: true
  validate :validate_workers_role

  def validate_workers_role
    if Worker.find(responsible_id).role != 'Conducteur de travaux'
      errors.add(:responsible_id, "sélectionné n'est pas défini comme 'Conducteur de travaux' dans la base de données")
    end
    if Worker.find(team_manager_id).role != "Chef d'équipe"
      errors.add(:team_manager_id, "sélectionné n'est pas défini comme 'Chef d'équipe' dans la base de données")
    end
    if Worker.find(site_manager_id).role != "Chef de chantier"
      errors.add(:site_manager_id, "sélectionné n'est pas défini comme 'Chef de chantier dans la base de données")
    end
  end
end
