#!/usr/bin/python3
import subprocess
import pathlib
import os
from string import Template

custom_waymo = '''I have studied the self-driving technology scene extensively, and
to me, Waymo is in a league of its own.
Seeing Waymo Driver reason about human intent from the tiniest movements of a car,
bike or pedestrian speaks volumes about the concentration of talent at Waymo.
'''

custom_nuro = '''For me, what differentiates Nuro, from the competition, is watching
Albert Meixner explain your Autonomy Stack. The clarity of the
explanations and no-nonsense language speaks volumes about the
concentration of talent at Nuro.
'''

custom_cruise = '''I have watched the whole "Cruise Under The Hood" series.
For me, this is what differentiates you from the competition.
The clarity of the explanations and no-nonsense language speaks volumes about the
concentration of talent at Cruise.
'''

companies = [
        {'name':'Waymo', 'custom': custom_waymo, 'positions':[
            {'full':'Senior Software Engineer, Perception, Robotics',
             'slug':'senior-sw-eng-perception-robotics'},
            {'full':'Software Engineer, Navigation & Sensor Fusion',
             'slug':'sw-eng-navigation-and-sensor-fusion'},
            {'full':'Software Engineer, Planner, Motion Planning',
             'slug':'sw-eng-planner-motion-planning'},
            {'full':'Software Engineer, Motion Control',
             'slug':'sw-eng-motion-control'},
        ], },
        {'name':'Cruise', 'custom': custom_cruise, 'positions':[
            {'full':'Senior Software Engineer II, Maneuver Planning',
             'slug':'senior-sw-eng-maneuver-planning'},
            {'full':'Senior Software Engineer, Controls',
             'slug':'senior-sw-eng-controls'},
            {'full':'Staff Robotics Engineer, Controls',
             'slug':'staff-robotics-eng-controls'},
            {'full':'Staff Robotics Engineer, Planning',
             'slug':'staff-robotics-eng-planning'},
        ], },
        {'name':'Nuro', 'custom': custom_nuro, 'positions':[
            {'full':'Software Engineer, Pose',
             'slug':'sw-eng-pose'},
            {'full':'Senior Software Engineer, Maneuver Planning',
             'slug':'senior-sw-eng-maneuver-planning'},
            {'full':'Controls Engineer',
             'slug':'controls-engineer'},
        ], },
        ]

with open('cover-letter-self-driving.md') as f:
    cover_letter_template = f.read()

cover_let_path = pathlib.Path('cover-letters')
assert cover_let_path.is_dir()

for company in companies:
    n = company['name']
    cust = company['custom']
    nslug = n.lower()

    comp_path = cover_let_path / nslug
    if not comp_path.exists():
        os.mkdir(comp_path)

    for position in company['positions']:
        pos_dir = comp_path / position['slug']
        pos_file = pos_dir / 'cover-letter.md'
        if not pos_dir.exists():
            os.mkdir(pos_dir)
        with open(pos_file, 'w') as f:
            temp = Template(cover_letter_template)
            subst = temp.substitute({'company_name':n, 'custom':cust, 'position_name':position['full']})
            #print(subst)
            f.write(subst)
        

cover_letter_dir = pathlib.Path('cover-letters')

for companies_dir in cover_letter_dir.iterdir():
    for job_positions in pathlib.Path(companies_dir).iterdir():
        jobdir = pathlib.Path(job_positions)
        cv_path = jobdir / 'cover-letter.md'
        if cv_path.exists() and cv_path.is_file():
            output_path = jobdir / 'cover_letter_morten_lysgaard.pdf'
            cmd = f'pandoc -o {output_path} --template=cover_letter_latex.template.tex --read=markdown+grid_tables+footnotes -t latex {cv_path}'
            #print(cmd)
            subprocess.run(cmd.split(' '))
