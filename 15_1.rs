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

    println!("{:?}", find(&mem, vec![], 0, 0).unwrap_or_else(|e| {
        eprintln!("err: {}", e);
        process::exit(1);
    }));
}

struct Point {
    x: i64,
    y: i64,
}

fn mv(mem: &[i64], path: &[i64], cmd: i64) -> Result<i64, Box<dyn Error>> {
    let mut c = IntcodeComputer::new()
        .load_mem_pad(mem)
        .debug(false)
        .init();

    for m in path {
        c.input(*m);
    }
    c.input(cmd);

    c.run()?;
    match c.outputs.pop() {
        Some(r) => Ok(r),
        None => Err("no output provided after movement command".into()),
    }
}
    
fn find(mem: &[i64], path: Vec<i64>, x: i64, y: i64) -> Result<usize, Box<dyn Error>> {
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
        let res = mv(mem, &path, cmd)?;
        match res {
            1 => return find(mem, [path.as_slice(), &[cmd]].concat(), 0, 0),
            2 => return Ok(path.len()),
            _ => (),
        };
    }

    Ok(0)
}
