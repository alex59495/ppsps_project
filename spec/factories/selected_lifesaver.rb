FactoryBot.define do
  factory :selected_lifesaver do
    worker { association(:worker_lifesaver) }
    ppsp
  end
end
