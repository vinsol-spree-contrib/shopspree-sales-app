Deface::Override.new(
  virtual_path: 'spree/admin/taxons/_form',
  name: 'add_suggestable_to_taxons',
  insert_bottom: 'div[data-hook=admin_inside_taxon_form]',
  text: %Q{
           <%= f.field_container :suggestable, class: ['form-group'] do %>
             <%= f.label :suggestable %>
             <%= f.check_box :suggestable, class: 'form-control' %>
           <% end %>
  }
)
