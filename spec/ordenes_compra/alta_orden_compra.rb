require 'spec_helper.rb'

feature "Alta de órden de compra" do
  #scenario "Acceso no autorizado" do
  #  visit "/orden_compra"
  #  click_link "Tramitar pedido"
    #page.should have_content "Acceso no autorizado" #O algo así
  #end

  scenario "Crear nueva órden de compra con datos válidos" do
    visit "/orden_compra"
    click_link "Tramitar pedido"

    #ingreso de datos

    click_button "Pagar"
    #page.should have_content "" #Mensaje de confirmación
  end

  scenario "Crear nueva órden de compra con datos incorrectos" do
    visit "/orden_compra"
    click_link   "Tramitar pedido"
    click_button "Crear"
    #page.should have_content "" #Mensaje de error
  end
end
