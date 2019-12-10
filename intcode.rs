enum ParamMode {
    Immediate,
    Position,
    Relative,
}

struct InputParam {
    value: i16,
    mode: ParamMode,
}

struct OutputParam {
    value: i16,
}

#[allow(non_camel_case_types)]
enum Intcode {
    ADD(InputParam, InputParam, OutputParam),
    MULT(InputParam, InputParam, OutputParam),
    SET(OutputParam),
    DISP(InputParam),
}

fn get_modes(mut intcode: i16) -> [i16; 4] {
  let c = intcode / 10000;
  intcode -= c * 10000;
  let b = intcode / 1000;
  intcode -= b * 1000;
  let a = intcode / 100;
  intcode -= a * 100;
  [intcode, c, b, a]
}
