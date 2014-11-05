within IDEAS.DistrictHeating.Production.HeatSources;
model HeatPump
  //Extensions
  extends BaseClasses.PartialHeatSource(
    redeclare IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump data);

  //Variables
  Real cop;
  Modelica.SIunits.Power PEl;

  //Components
  Modelica.Blocks.Tables.CombiTable2D copTable(
    table=data.cop)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Tables.CombiTable2D powerTable(
    table=data.power)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
        transformation(extent={{-28,66},{12,106}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-2,88})));

equation
  //Calculation of the heat provided by the heatpump
  cop = if on then  copTable.y else 1;
  PEl = if on then  powerTable.y * scaler else 0;
  heatPort.Q_flow=PEl*cop;

end HeatPump;
