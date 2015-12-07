FactoryGirl.define do
  factory :therapist do
    username            "ziggy56"
    password            "aCigarisjustaCigar"
    first_name          "Sigmund"
    last_name           "Freud"
    address             "111 Main St"
    city                "New York"
    state               "NY"
    country             "United States"
    practice            "Not if I can help it."
    years_experience    25
    qualifications      "I, literally, wrote the book."
    gender              "male"
    religion            "N/A"
    licenses            "OK, TX, NY, Nightvale"
    main_license        "NY"
    distance_counseling true
    purpose             "To mitigate my anui."
    email               "ziggystardust01@example.com"
    phone               "5558675309"
    zipcode             "23523-23442"
  end
end
