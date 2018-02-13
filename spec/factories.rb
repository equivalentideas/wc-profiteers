FactoryBot.define do
  factory :contractor do
    name "Foo Company"
    abn "123"
  end

  factory :contract do
    can_id '123'
  end
end
