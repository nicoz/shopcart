# == Schema Information
#
# Table name: orden_compras
#
#  id         :integer          not null, primary key
#  total      :float
#  estado     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class OrdenCompra < ActiveRecord::Base
  #belongs_to :usuario
  #has_many   :articulo, throught: :articulo_orden_compra
  #has_many   :dato_facturacion
end
