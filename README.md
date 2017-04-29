# Dashboard with RoR and Dashing.

- app/views/dashing/dashboards — One .erb file for each dashboard that contains the layout for the widgets.
- app/jobs — Your ruby jobs for fetching data (e.g for calling third party APIs like twitter).
- app/assets/javascripts/dashing/widgets/ — A widget's name .coffee file containing your widget's js.
- app/assets/stylesheets/dashing/widgets/ — A widget's name .scss file containing your widget's css.
- app/views/dashing/widgets/ — A widget's name .html file containing your widget's html.
- app/views/layouts/dashing/ — All your custom layouts where your dashboards and widgets will be included.
