use std::fs;
use std::path::Path;
use std::error::Error;

#[derive(Debug)]
pub enum ParamMode {
    Position,
    Immediate,
    Relative,
    Invalid,
}

impl ParamMode {
    fn from(mode: i16) -> Self {
        match mode {
            0 => Self::Position,
            1 => Self::Immediate,
            2 => Self::Relative,
            _ => Self::Invalid,
        }
    }
}

#[derive(Debug)]
pub struct InputParam {
    value: i16,
    mode: ParamMode,
}

impl InputParam {
    fn new(value: i16, mode: i16) -> Self {
        InputParam {value, mode: ParamMode::from(mode)}
    }

    fn get(&self, comp: &IntcodeComputer) -> Result<i16, Box<dyn Error>> {
        match self.mode {
            ParamMode::Immediate => Ok(self.value),
            ParamMode::Position => {
                if let Some(v) = comp.mem.get(self.value as usize) {
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
    address: i16,
}

impl OutputParam {
    fn new(address: i16) -> Self {
        OutputParam {address}
    }

    fn set(&self, comp: &mut IntcodeComputer, value: i16) {
        comp.mem[self.address as usize] = value;
    }
}

#[allow(non_camel_case_types)]
#[derive(Debug)]
pub enum Intcode {
    ADD(InputParam, InputParam, OutputParam),
    MULT(InputParam, InputParam, OutputParam),
    SET(OutputParam),
    DISP(InputParam),
    STOP(),
    ERR(),
}

impl Intcode {
    pub fn get(comp: &IntcodeComputer) -> Self {
        let val = comp.mem[comp.ic];
        let op_modes = Self::get_opcode_and_param_modes(val);
        match op_modes[0] {
            1 => Self::ADD(InputParam::new(comp.mem[comp.ic+1], op_modes[1]),
                    InputParam::new(comp.mem[comp.ic+2], op_modes[2]),
                    OutputParam::new(comp.mem[comp.ic+3])),
            2 => Self::MULT(InputParam::new(comp.mem[comp.ic+1], op_modes[1]),
                    InputParam::new(comp.mem[comp.ic+2], op_modes[2]),
                    OutputParam::new(comp.mem[comp.ic+3])),
            3 => Self::SET(OutputParam::new(comp.mem[comp.ic+1])),
            4 => Self::DISP(InputParam::new(comp.mem[comp.ic+1], op_modes[1])),
            99 => Self::STOP(),
            _ => Self::ERR(),
        }
    }

    pub fn exec(&self, comp: &mut IntcodeComputer) -> Result<bool, Box<dyn Error>> {
        let mut c = true;
        match self {
            Self::ADD(i, j, o) => o.set(comp, i.get(comp)? + j.get(comp)?),
            Self::MULT(i, j, o) => o.set(comp, i.get(comp)? * j.get(comp)?),
            Self::SET(_) => (),
            Self::DISP(_) => (),
            Self::STOP() => (c = false),
            Self::ERR() => return Err("invalid intcode".into()),
        };
        comp.ic += self.len();
        Ok(c)
    }

    fn len(&self) -> usize {
        match self {
            Self::ADD(_, _, _) => 4,
            Self::MULT(_, _, _) => 4,
            Self::SET(_) => 2,
            Self::DISP(_) => 2,
            _ => 0,
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
    pub mem: Vec<i16>,
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

    pub fn run(&mut self) -> Result<(), Box<dyn Error>> {
        loop {
            // get intcode
            let intcode = Intcode::get(&self);
            println!("[{}] {:?}", self.ic, intcode);
            // exec intcode
            if !intcode.exec(self)? {
                break Ok(());
            }
        }
    }
}
