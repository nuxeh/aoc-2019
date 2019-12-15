use std::fs;
use std::path::Path;
use std::error::Error;

//mod ops;

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

impl InputParam {
    fn value(&self, mem: &Vec<i16>) -> Result<i16, Box<dyn Error>> {
        match self.mode {
            ParamMode::Immediate => Ok(self.value),
            ParamMode::Position => {
                if let Some(v) = mem.get(self.value as usize) {
                    Ok(v.clone())
                } else {
                    Err("invalid address".into())
                }
            },
            _ => Err("unimplemented input parameter type".into()),
        }
    }
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
    pub fn get(comp: &IntcodeComputer) -> Self {
        println!("{}", comp.mem[comp.ic]);
        Self::ADD(InputParam {value: 0, mode: ParamMode::Position},
                  InputParam {value: 0, mode: ParamMode::Position},
                  OutputParam {value: 0})
    }

    pub fn exec(mem: &mut Vec<i16>, ic: usize) -> usize {
        42
    }

    fn len(&self) -> usize {
        match self {
            Self::ADD(_, _, _) => 4,
            Self::MULT(_, _, _) => 4,
            Self::SET(_) => 2,
            Self::DISP(_) => 2,
        }
    }

    fn get_opcode_and_param_modes(mut intcode: i16) -> [i16; 4] {
        let c = intcode / 10000;
        intcode -= c * 10000;
        let b = intcode / 1000;
        intcode -= b * 1000;
        let a = intcode / 100;
        intcode -= a * 100;
        [intcode, c, b, a]
    }
}

pub fn read_file(path: impl AsRef<Path>) -> Result<Vec<i16>, Box<dyn Error>> {
    let v: Vec<i16> = fs::read_to_string(path)?
        .split(",")
        .map(|c| c.parse().unwrap_or(0))
        .collect();
    Ok(v)
}

#[derive(Debug, Clone)]
pub struct IntcodeComputer {
    /// memory
    mem: Vec<i16>,
    /// instruction counter
    ic: usize,
    inputs: Vec<i16>,
    outputs: Vec<i16>,
}

impl IntcodeComputer {
    pub fn new() -> Self {
        Self {
            mem: vec!(),
            ic: 0,
            inputs: vec!(),
            outputs: vec!(),
        }
    }

    pub fn load_mem(&mut self, mem: Vec<i16>) -> &mut Self {
        self.mem = mem;
        self
    }

    pub fn input(&mut self, input: i16) -> &mut Self{
        self.inputs.push(input);
        self
    }

    pub fn init(&self) -> Self {
        self.clone()
    }

    pub fn run() {
        // get intcode
        // exec intcode
        // jump to new entry point
    }
}
