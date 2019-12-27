use std::env;
use std::error::Error;
use std::path::PathBuf;
use std::process;

mod intcode;

use intcode::IntcodeComputer;

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    let mut comp = IntcodeComputer::new()
        .load_mem_pad(&mem)
        .debug(false)
        .init();

    println!("{:?}", find(&mut comp, vec![], 0, 0).unwrap_or_else(|e| {
        eprintln!("err: {}", e);
        process::exit(1);
    }));
}

struct Point {
    x: i64,
    y: i64,
}

const step_back: [i64; 4] = [2, 1, 4, 3];

fn mv(c: &mut IntcodeComputer, cmd: i64) -> Result<i64, Box<dyn Error>> {
    c.input(cmd);
    c.run()?;
    if let Some(r) = c.outputs.pop() {
        match r {
            0 => Ok(0),
            1 => {
                c.input(step_back[cmd as usize]);
                c.run()?;
                Ok(1)
            },
            2 => {
                c.input(step_back[cmd as usize]);
                c.run()?;
                Ok(2)
            },
            _ => Err("invalid return value".into()),
        }
    } else {
       Err("no output provided after movement command".into())
    }
}
    
fn find(
    comp: &mut IntcodeComputer, path: Vec<i64>, x: i64, y: i64
)-> Result<usize, Box<dyn Error>> {
//    (1..=4)
//        .try_map(|cmd| mv(mem, &path, cmd))?
//        .for_each(|m| {
//            match m {
//                1 => find(mem, [path.as_slice(), &[cmd]].concat(), 0, 0),
//                2 => Ok(path.len()),
//            };
//        });

    //println!("find");
    for cmd in 1..=4 {
        //println!("{}", cmd);
        let res = mv(comp, cmd)?;
        match res {
            1 => return find(comp, [path.as_slice(), &[cmd]].concat(), 0, 0),
            2 => {
                eprintln!("found it, {}", path.len());
                return Ok(path.len())
            },
            _ => (),
        };
    }

    Ok(0)
}
