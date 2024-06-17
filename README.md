# Query-based Autonomous Capability Estimation (QACE) Algorithm

This repository contains the code for the paper:

Autonomous Capability Assessment of Sequential Decision-Making Systems in Stochastic Settings.<br/>
[Pulkit Verma](https://pulkitverma.net),
[Rushang Karia](https://rushangkaria.github.io), and 
[Siddharth Srivastava](http://siddharthsrivastava.net/). <br/>
37th Conference on Neural Information Processing Systems (NeurIPS), 2023.

[Paper](https://aair-lab.github.io/Publications/vks_neurips23.pdf) | [Extended Version](https://arxiv.org/pdf/2306.04806) | [Short Talk \[NeurIPS Page\]](https://nips.cc/virtual/2023/poster/71433) | [Slides](https://pulkitverma.net/assets/pdf/vks_neurips23/vks_neurips23_slides.pdf) | [Poster](https://pulkitverma.net/assets/pdf/vks_neurips23/vks_neurips23_poster.pdf)

<br>

## Requirements
* Ubuntu 18.04 or greater
* Python3 (>= 3.6.9)

> **[Note]** <br>
> For ubuntu 20.04 and greater users, python is not mapped to python3.
> Run `sudo apt install python-is-python3` to link python to python3.

<br>

## Installation

1. Run the followin command in a terminal
```
sudo apt install make g++ python3-venv graphviz gcc-multilib g++-multilib graphviz-dev
sudo apt install docker.io
```

> **[Note]** <br>
> For ARM processors, use `gcc-multilib-i686-linux-gnu` and `g++-multilib-i686-linux-gnu` on place of `gcc-multilib` and `g++-multilib`, respectively.

2. Build PRP
```
pushd dependencies/prp/src
./build_all
popd
```

3. Setup a virtual environment
```
python3 -m venv env
source env/bin/activate
```

4. Install the required python libraries.

```
pip3 install --upgrade pip
pip3 install networkx
pip3 install pydot
pip3 install gym
pip3 install pddlgym
pip3 install pygraphviz
pip3 install argparse
pip3 install tqdm
pip3 install termcolor
pip3 install pygraphviz
pip3 install seaborn
pip3 install graphviz
pip3 install docker
pip3 install urllib3==1.26.0
```

<br>

> **[Note]** <br>
> An earlier version of QACE was inernally called Stochastic Agent Interrogation Algorithm (SAIA). These references to `saia` can be found at multiple places, please consider them as `qace`. 
<br>

## Running the experiments

[Domains]<br> 
Paper contains 5 SDMA (Sequential Decision-Making Agent) setup: Warehouse Robot, Driver Agent, First Responder Robot, Elevator Control Agent, and Cafe Server Robot. These are based on the classical domains used in literature. The code use their traditional classical domain names. This mapping is available below:

| SDMA Setup | Name Used in Code |
| ---------- | ---------------- |
| Warehouse Robot | Explodingblocks |
| Driver Agent | Tireworld |
| First Responder Robot | First_responders |
| Elevator Control Agent | Probabilistic_elevators |
| Cafe Server Robot | Cafeworld |

<br>

> **[Note]** <br>
> * All results will use the <root_dir>/results to put the results in.
> * [a|b|c|d|e] means one of the options among the set \{a,b,c,d,e\}.
> * <root_dir> should be a fully qualified path name to the project root dir.

### Step 1: Generating variational distance data
Always run this first for any domain

```
PYTHONHASHSEED=0 python3 src/main.py --base-dir <root_dir>/results/ --gym-domain-name [Tireworld|Explodingblocks|Probabilistic_elevators|First_responders|Cafeworld] --vd
```
### Step 2:  Running Individual Algorithms

1. Running QACE
```
PYTHONHASHSEED=0 python3 src/main.py --base-dir <root_dir>/results/ --gym-domain-name [Tireworld|Explodingblocks|Probabilistic_elevators|First_responders|Cafeworld] --qace --randomize-pal --count-sdm-samples
```
2. Running GLIB-G
```
PYTHONHASHSEED=0 python3 src/main.py --base-dir <root_dir>/results/ --gym-domain-name [Tireworld|Explodingblocks|Probabilistic_elevators|First_responders] --glib --curiosity-name GLIB_G1
```
3. Running GLIB-L
```
PYTHONHASHSEED=0 python3 src/qace.py --base-dir results/ --gym-domain-name [Tireworld|Explodingblocks|Probabilistic_elevators|First_responders] --glib --curiosity-name GLIB_L2
```


## Results

The results used for the plots in the paper can be found in the `results` directory. They should remain same if you run them on your own with the exact same setup. Timing values might change a bit though depending on your hardware setup.


Please note that this is research code and not yet ready for public delivery,
hence most parts are not documented.

In case of any queries, please contact [verma.pulkit@asu.edu](mailto:verma.pulkit@asu.edu),
or [rushang.karia@asu.edu](mailto:rushang.karia@asu.edu).

<br/>


# Citation
```
@inproceedings{verma2023autonomous,
  author    = {Verma, Pulkit and Karia, Rushang and Srivastava, Siddharth},
  title     = {Autonomous Capability Assessment of Sequential Decision-Making Systems in Stochastic Settings},
  booktitle = {Proceedings of the Thirty-seventh Conference on Neural Information Processing Systems ({NeurIPS})},
  year      = {2023},
}
```


