within IDEAS.DistrictHeating.Production;
model HeatPump
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(
    redeclare BaseClasses.PartialHeatPump data,
      QNomRef=data.QNomRef,
      etaRef=data.etaRef,
      TMax=data.TMax,
      TMin=data.TMin,
      modulationMin=data.modulationMin,
      modulationStart=data.modulationStart,
      redeclare HeatSources.HeatPump heatSource(
        redeclare package Medium = Medium,
        data=data));

  Modelica.Blocks.Interfaces.BooleanInput on "on/off control for the heatpump"
    annotation (Placement(transformation(extent={{-132,-20},{-92,20}})));
equation
  PEl = heatSource.PEl;
  PFuel = 0;
  connect(on, heatSource.on) annotation (Line(
      points={{-112,0},{-78,0},{-78,52},{-11.8,52},{-11.8,71.2}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics));
end HeatPump;
