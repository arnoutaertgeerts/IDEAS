within IDEAS.DistrictHeating.HeatingSystems.BaseClasses;
partial model HeatingFluidTwoPort
  extends IDEAS.Interfaces.BaseClasses.HeatingSystem;

  import Modelica.Constants;

  replaceable package Medium =Modelica.Media.Interfaces.PartialMedium
    "Medium in the component"
      annotation (choicesAllMatching = true);

  parameter Boolean allowFlowReversal = true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a portSupplyIn(redeclare final package
      Medium = Medium, m_flow(min=if allowFlowReversal then -Constants.inf
           else 0))
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{70,90},{90,110}}, rotation=0)));
  Modelica.Fluid.Interfaces.FluidPort_b portReturnOut(redeclare final package
      Medium = Medium, m_flow(max=if allowFlowReversal then +Constants.inf
           else 0))
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,90},{30,110}}, rotation=0),
        iconTransformation(extent={{50,90},{30,110}})));
  // Model structure, e.g., used for visualization
protected
  parameter Boolean port_a_exposesState = false
    "= true if port_a exposes the state of a fluid volume";
  parameter Boolean port_b_exposesState = false
    "= true if port_b.p exposes the state of a fluid volume";
  parameter Boolean showDesignFlowDirection = true
    "= false to hide the arrow in the model icon";

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -100},{200,100}}), graphics));
end HeatingFluidTwoPort;
