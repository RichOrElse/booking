module ParseValuesAtMembers
  def parse(data)
    return {} if data.blank?

    new(*data.values_at(*members)).to_h
  end
end
