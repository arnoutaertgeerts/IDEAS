within IDEAS.Thermal.Components.BaseClasses;
model Pump_HeatPort
  "Prescribed mass flow rate, with heatPort for heat exchange."

  extends Thermal.Components.Interfaces.Partials.TwoPort;
  parameter Boolean useInput=false "Enable / disable MassFlowRate input"
    annotation (Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flowNom(min=0, start=1)
    "Nominal mass flowrate" annotation (Dialog(enable=not useVolumeFlowInput));
  parameter Modelica.SIunits.Pressure dpFix=50000
    "Fixed pressure drop, used for determining the electricity consumption";
  parameter Real etaTot=0.8 "Fixed total pump efficiency";
  Modelica.Blocks.Interfaces.RealInput m_flowSet(
    start=0,
    min=0,
    max=1) = m_flow/m_flowNom if useInput annotation (Placement(transformation(
        origin={0,100},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat exchange with environment" annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}, rotation=0)));

protected
  Modelica.SIunits.MassFlowRate m_flow;

public
  Modelica.Blocks.Interfaces.RealOutput PEl "Electricity consumption"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-106})));
equation
  // energy exchange with medium
  Q_flow = heatPort.Q_flow;
  // defines heatPort's temperature
  heatPort.T = T;

  if not useInput then
    m_flow = m_flowNom;
  end if;

  flowPort_a.m_flow = m_flow;
  PEl = m_flow/medium.rho*dpFix/etaTot;
  annotation (
    Documentation(info="<html>
<p><b>Description</b> </p>
<p>Basic pump model with heatPort for heat exchange. This model sets the mass flow rate, either as a constant or based on an input. The thermal equations are identical to the <a href=\"modelica://IDEAS.Thermal.Components.BaseClasses.Pipe_HeatPort\">Pipe_HeatPort</a> model.</p>
<p>If an input is used (<code>useInput&nbsp;=&nbsp;true)</code>, <code>m_flowSet</code> is supposed to be a real value between 0 and 1, and the flowrate is then <code>m_flowSet * m_flowNom.</code></p>
<p>The model calculates the electricity consumption of the pump in a very simplified way: a fixed pressure drop and an efficiency are given as parameters, and the electricity consumption is computed as:</p>
<pre>PEl&nbsp;=&nbsp;m_flow&nbsp;/&nbsp;medium.rho&nbsp;*&nbsp;dpFix&nbsp;/&nbsp;etaTot;</pre>
<p><h4>Assumptions and limitations </h4></p>
<p><ol>
<li>This model does not specify a relation between pressure and flowrate, the flowrate is IMPOSED</li>
<li>If the water content of the pump, m, is zero, there are no thermal dynamics. </li>
<li>The electricity consumption is computed based on a FIXED efficiency and FIXED pressure drop AS PARAMETERS</li>
<li>The inefficiency of the pump does NOT lead to an enthalpy increase of the outlet flow.</li>
</ol></p>
<p><h4>Model use</h4></p>
<p><ol>
<li>Decide if the pump will be controlled through an input or if the flowrate is a constant</li>
<li>Set medium and water content of the pump</li>
<li>Specify the parameters for computing the electricity consumption</li>
<li>Connect the heatPort</li>
</ol></p>
<p><h4>Validation </h4></p>
<p>None</p>
<p><h4>Example </h4></p>
<p>The <a href=\"modelica://IDEAS.Thermal.Components.Examples.PumpePipeTester\">PumpPipeTeste</a>r model uses <a href=\"modelica://IDEAS.Thermal.Components.BaseClasses.Pump\">Pump</a> models but they can easily be replaced with this Pump_HeatPort model.</p>
</html>", revisions="<html>
<p><ul>
<li>May 2013, Roel De Coninck, documentation</li>
<li>March 2013, Ruben Baetens, graphics</li>
<li>October 2012, Roel De Coninck, first version.</li>
</ul></p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Text(
          extent={{-150,-94},{150,-154}},
          lineColor={0,0,255},
          textString="%name"),Text(
          extent={{-40,20},{0,-20}},
          lineColor={0,0,0},
          textString="V"),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={135,135,135},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-40,20},{0,-20}},
          lineColor={0,0,0},
          textString="V"),Line(
          points={{-100,0},{-60,0}},
          color={0,128,255},
          smooth=Smooth.None),Line(
          points={{100,0},{60,0}},
          color={0,128,255},
          smooth=Smooth.None),Line(
          points={{0,0},{0,80}},
          color={0,0,127},
          smooth=Smooth.None),Line(
          points={{-40,80},{40,80}},
          color={0,0,127},
          smooth=Smooth.None),Polygon(
          points={{-38,46},{60,0},{60,0},{-38,-46},{-38,46}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics));
end Pump_HeatPort;
