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

    #within "#usuario" do
    #  click_link "Asignar usuario"
      #Asignar un usuario con ajax
    #end

    #within "#datos_facturacion" do
    #  click_link "Agregar datos de facturacion"
      #Agregar un par de datos de facturación por medio de ajax
    #end

    #within "#articulos" do
    #  click_link "Agregar artículo"
      #Agregar articulos por medio de ajax
    #end

    click_button "Crear"
    #page.should have_content "" #Mensaje de confirmación
  end

  scenario "Crear nueva órden de compra con datos incorrectos" do
    visit "/orden_compra"
    click_link   "Tramitar pedido"
    click_button "Crear"
    #page.should have_content "" #Mensaje de error
  end
end
