OrgChartPortfolio::Application.routes.draw do
  
  resources :org_chart_nodes
  resources :org_charts
  match "org_chart_nodes/move_node" => "org_chart_nodes#move_node"
  root :to => 'main#main'

end
