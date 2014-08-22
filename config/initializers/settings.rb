module Settings
  # again - it's a singleton, thus implemented as a self-extended module
  extend self

  def get(key)

    data = YAML::load_file("#{Rails.root}/config/appdata.yml")

    if data[key].present?
      data[key]
    else
      ""
    end

  end

end