module Hardness
  def data
    {"talc" => 1, "calcite" => 3, "apatite" => 5, "corundum" => 9}
  end

  def hardness
    data[self.common_name]
  end
end
