use std::fs;
use std::path::Path;
use std::error::Error;

#[derive(Debug)]
pub enum ParamMode {
    Immediate,
    Position,
    Relative,
}

#[derive(Debug)]
pub struct InputParam {
    value: i16,
    mode: ParamMode,
}

#[derive(Debug)]
pub struct OutputParam {
    value: i16,
}

#[allow(non_camel_case_types)]
#[derive(Debug)]
pub enum Intcode {
    ADD(InputParam, InputParam, OutputParam),
    MULT(InputParam, InputParam, OutputParam),
    SET(OutputParam),
    DISP(InputParam),
}

impl Intcode {
    pub fn get(mem: &Vec<i16>, ic: usize) -> Self {
        println!("{}", mem[ic]);
        Self::ADD(InputParam {value: 0, mode: ParamMode::Position},
                  InputParam {value: 0, mode: ParamMode::Position},
                  OutputParam {value: 0})
    }

    fn len(&self) -> usize {
        match self {
            Self::ADD(_, _, _) => 4,
            Self::MULT(_, _, _) => 4,
            Self::SET(_) => 2,
            Self::DISP(_) => 2,
        }
    }

    fn get_op_modes(mut intcode: i16) -> [i16; 4] {
        let c = intcode / 10000;
        intcode -= c * 10000;
        let b = intcode / 1000;
        intcode -= b * 1000;
        let a = intcode / 100;
        intcode -= a * 100;
        [intcode, c, b, a]
    }
}

pub fn read(path: impl AsRef<Path>) -> Result<Vec<i16>, Box<dyn Error>> {
    let v: Vec<i16> = fs::read_to_string(path)?
        .split(",")
        .map(|c| c.parse().unwrap_or(0))
        .collect();
    Ok(v)
}
