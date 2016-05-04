require 'pstore'
namespace :import do
  desc 'Migrate data over from mysql to development database'
  task import_patients: :environment do
    connection = Mysql2::Client.new(
      host:     'seculartherapy.org',
      port:     3306,
      database: 'therapy_main',
      username: 'therapy_user',
      password: 'Garcia999!'
    )
    clients = connection.query('SELECT * FROM clients')
    clients.each do |c|
      p = Patient.new
      p.id              = c['cluniquecode'].to_i
      p.username        = c['clusername']
      p.password        = c['clpassword']
      p.name            = c['clname'].empty? ? 'unknown' : c['clname']
      p.phone           = c['cltel'].empty?  ? 0000000000 : c['cltel']
      p.email           = c['clemail']
      p.zipcode         = c['clzip']
      p.gender          = c['clgender'] == 'M' ? 'Male' : 'Female'
      p.former_religion = c['claffiliation'].empty? ? 'unknown' : c['claffiliation']
      p.description     = c['clproblem'].empty? ? 'unknown' : c['clproblem']
      p.created_at      = c['clappdate']
      p.verified_at     = c['clappdate']
      if p.valid? && Patient.find_by(email: p.email).nil?
        p.save!
        p 'saved'
      else
        u = Patient.find_by(email: p.email)
        if u
          if p.username == u.username
            p 'Already exists'
          else
            u.destroy
            if p.valid?
              p.save!
              p 'saved after deletion'
            else
              p "ERROR!!!"
            end
          end
        else
          puts "sending #{p} to pstore"
          store = PStore.new("bad_users.pstore")
          store.transaction do
            store[p.id] = p
          end
        end
      end
    end
  end

  desc 'Update patient location data'
  task patient_locations: :environment do
    connection = Mysql2::Client.new(
      host:     'seculartherapy.org',
      port:     3306,
      database: 'therapy_main',
      username: 'therapy_user',
      password: 'Garcia999!'
    )
    Patient.find_each do |p|
      if p.latitude.nil? && p.longitude.nil?
        location = connection.query("SELECT * FROM zipcodes WHERE ZIPCode=#{p.zipcode.gsub(' ', '')}").first
        if location
          p.latitude = location['Latitude']
          p.longitude = location['Longitude']
          p.save!
        end
      end
    end
  end

  desc 'Migrate therapists over from mysql to development database'
  task import_therapists: :environment do
    connection = Mysql2::Client.new(
      host:     'seculartherapy.org',
      port:     3306,
      database: 'therapy_main',
      username: 'therapy_user',
      password: 'Garcia999!'
    )
    therapists = connection.query('SELECT * FROM therapists')
    therapists.each do |c|
      t = Therapist.new
      t.id               = c['thuniquecode'].to_i
      t.username         = c['thusername']
      t.password         = c['thpassword']
      t.first_name       = c['thfirstname']
      t.last_name        = c['thlastname']
      t.phone            = c['thtel'].empty?  ? 0000000000 : c['thtel']
      t.email            = c['themail']
      t.address          = [c['thaddress1'], c['thaddress2'], c['thaddress3']].join(', ')
      t.city             = c['thtown']
      t.state            = c['thstate']
      t.country          = c['thcountry']
      t.zipcode          = c['thzip']
      t.practice         = c['thtype']
      t.years_experience = c['thyears']
      t.qualifications   = c['thqualifications']
      t.adolescents             = c['thsp1']
      t.adults                  = c['thsp2']
      t.children                = c['thsp3']
      t.coping_with_change      = c['thsp4']
      t.depression              = c['thsp5']
      t.existential             = c['thsp6']
      t.general_anxiety         = c['thsp7']
      t.grief_loss              = c['thsp8']
      t.marriage_family         = c['thsp9']
      t.mood_disorders          = c['thsp10']
      t.ocd                     = c['thsp11']
      t.ptsd                    = c['thsp12']
      t.relationship_counseling = c['thsp13']
      t.self_improvement        = c['thsp14']
      t.sex_therapy             = c['thsp15']
      t.social_anxiety          = c['thsp16']
      t.stress_management       = c['thsp17']
      t.substance_abuse         = c['thsp18']
      t.trauma_recovery         = c['thsp19']
      t.website             = c['thurl']
      t.gender              = c['thgender'] == 'M' ? 'Male' : 'Female'
      t.religion            = c['thaffiliation'].empty? ? 'unknown' : c['thaffiliation']
      t.former_religion     = c['thpastaffiliation'].empty? ? 'unknown' : c['thpastaffiliation']
      t.licenses            = c['thlicenses']
      t.main_license        = c['thlstate']
      t.distance_counseling = c['thtelephone'] == 'Y'
      t.languages           = c['thlanguages'] || 'English'
      t.purpose             = c['thstatement']
      t.description         = c['statementpublic']
      t.approach            = c['thexamples'] || 'n/a' 
      t.created_at          = c['thappdate'] || '0000-00-00'
      t.verified_at         = t.created_at if c['thstatus'] == 'Active'
      t.application_status  = c['thstatus'].downcase
      t.geo_address         = [t.address, t.city, t.state, t.country, t.zipcode].join(', ')
      if t.valid? && Therapist.find_by(email: t.email).nil?
        t.save!
        puts 'saved'
      else
        u = Therapist.find_by(email: t.email)
        if u
          if t.username == u.username
            puts 'Already exists'
          else
            u.destroy
            if t.valid?
              t.save!
              puts 'saved after deletion'
            else
              t.errors.each { |error| p error }
              puts "sending #{t} to pstore"
              store = PStore.new("bad_therapists.pstore")
              store.transaction do
                store[t.id] = t
          end
            end
          end
        else
          t.errors.each { |error| p error }
          puts "sending #{t} to pstore"
          store = PStore.new("bad_therapists.pstore")
          store.transaction do
            store[t.id] = t
          end
        end
      end
    end
  end

  desc 'Migrate votes over'
  task application_votes: :environment do
    connection = Mysql2::Client.new(
      host:     'seculartherapy.org',
      port:     3306,
      database: 'therapy_main',
      username: 'therapy_user',
      password: 'Garcia999!'
    )
    votes = connection.query('SELECT * FROM appdis')
    votes.each do |c|
      admin = Therapist.find_by(username: c['user'])
      if admin
        admin_id = admin.id
      else
        puts "Something went wrong. Couldn't find"
        puts c['user']
        if c['user'] == 'Pguzikowski'
          admin_id = Therapist.find_by(username: 'PGuzikowski').id
          puts 'fixed'
        elsif c['user'] == 'caleblack2'
          admin_id = Therapist.find_by(username: 'caleblack').id
          puts 'fixed'
        else
          puts "Couldn't find solution"
          exit
        end
      end
      unless admin_id
        puts "COULDN'T FIND #{c['user']}"
        exit
      end
      unless Vote.find_by(voter_id: c['therapist'], votee_id: admin_id)
        v = Vote.new
        v.voter_id = c['therapist']
        v.votee_id = admin_id
        v.decision = c['appdis'] == 'Info' ? 'Need More Info' : c['appdis']
        v.comment  = c['comments']
        v.save!
        puts "Saved vote"
      else
        puts "Already exists"
      end
    end
  end

  desc 'Migrates over messages'
  task application_messages: :environment do
    connection = Mysql2::Client.new(
      host:     'seculartherapy.org',
      port:     3306,
      database: 'therapy_main',
      username: 'therapy_user',
      password: 'Garcia999!'
    )
    relationships = connection.query('SELECT * FROM messages')
    relationships.each do |c|
      unless PatientTherapistRelationship.find_by(
        patient_id:   c['meclidentifier'],
        therapist_id: c['methidentifier']
      )
        if Patient.exists?(c['meclidentifier']) && Therapist.exists?(c['methidentifier'])
          puts "Creating Relationship"
          relat = PatientTherapistRelationship.new(
            patient_id:   c['meclidentifier'],
            therapist_id: c['methidentifier'])
          relat.save!
          puts "Creating Conversation"
          Conversation.create!(
            patient_therapist_relationship_id: relat.id
          )
        end
      end
      rel = PatientTherapistRelationship.find_by(
          patient_id:   c['meclidentifier'],
          therapist_id: c['methidentifier'])
      convo = rel ? rel.conversation : false
      if c['mefromto'] == 'C' && convo
        puts "Creating message"
        Message.create!(
          sender_type:     'patient',
          sender_id:       c['meclidentifier'],
          receiver_type:   'therapist',
          receiver_id:     c['methidentifier'],
          conversation_id: convo.id,
          topic:           'None',
          body:            c['memessage'].blank? ? 'Nothing' : c['memessage'],
          created_at:      c['metimestamp']
        )
      elsif c['mefromto'] == 'T' && convo
        puts "Creating Message"
        Message.create!(
          sender_type:     'therapist',
          sender_id:       c['methidentifier'],
          receiver_type:   'patient',
          receiver_id:     c['meclidentifier'],
          conversation_id: convo.id,
          topic:           'None',
          body:            c['memessage'].blank? ? 'Nothing' : c['memessage'],
          created_at:      c['metimestamp']
        )
      end
    end
  end
end
