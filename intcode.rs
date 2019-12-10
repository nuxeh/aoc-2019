enum Parameter {
    Input(u8),
    Output(u8),
}

enum ParamMode {
    Immediate,
    Position,
    Relative,
}

struct InputParam {
    value: u8,
    mode: ParamMode,
}

struct OutputParam {
    value: u8,
}

enum Intcode {
    ADD(InputParam, InputParam, OutputParam),
    MULT(InputParam, InputParam, OutputParam),
    SET(OutputParam),
    DISP(InputParam),
}
