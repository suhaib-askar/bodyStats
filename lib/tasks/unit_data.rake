namespace :db do
  desc "Fill unit table with data"
  task unit: :environment do
    make_units
  end
end

def make_units
  Unit.create!(full_en: "milimeter",
                short_en: "mm",
                full_ru: "миллиметр",
                short_ru: "мм")
  Unit.create!(full_en: "centimeter",
                short_en: "cm",
                full_ru: "сантиметр",
                short_ru: "см")
  Unit.create!(full_en: "meter",
                short_en: "m",
                full_ru: "метр",
                short_ru: "м")
  Unit.create!(full_en: "kilogram",
                short_en: "kg",
                full_ru: "килограмм",
                short_ru: "кг")
  Unit.create!(full_en: "gram",
                short_en: "gm",
                full_ru: "грамм",
                short_ru: "г")
  Unit.create!(full_en: "time",
                short_en: "time",
                full_ru: "раз",
                short_ru: "раз")
end