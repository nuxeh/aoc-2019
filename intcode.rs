enum Parameter {
    Input(u8),
    Output(u8),
}

enum ParamMode {
    Immediate,
    Position,
    Relative,
}

enum Intcode {
    ADD(Parameter, Parameter::Input, Parameter::Output),
    MULT(Parameter::Input, Parameter::Input, Parameter::Output),
    SET(Parameter::Output),
    DISP(Parameter::Input),
}
