import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'counselling.dart'; // Import the AssessmentScreen

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  String? currentEmotion; // To track the current emotion selected
  String? currentQuery; // To track the current query selected
  String? currentSubQuery; // To track the current subquery selected

  Map<String, List<String>> emotionQuestions = {
    "Guilt": [
      "I feel guilty for not doing enough, even though I'm trying my best.",
      "How do I stop feeling guilty about past decisions?",
      "I hurt someone I care about, how can I make it right?",
      "I missed an important event, and now I feel like I've let everyone down, how can I cope?",
      "I didn't meet my own expectations, and now I feel worthless. What can I do?",
      "I have other query"
    ],
    "Loneliness": [
      "I feel really alone even when I'm surrounded by people, what can I do?",
      "How do I make friends in college when I feel so isolated?",
      "I feel disconnected from everyone, even my family, what should I do?",
      "I'm finding it hard to find my place at college, any advice?",
      "I miss home and feel lonely here, how can I cope with this feeling?",
      "I have other query"
    ],
    "Anxiety": [
      "I'm constantly worrying about my future, how can I stop overthinking?",
      "I get really anxious before exams, what can help me feel more in control?",
      "How can I manage the feeling of being overwhelmed with everything?",
      "I can't seem to relax, even when I try, what should I do?",
      "I feel nervous meeting new people, is that normal?",
      "I have other query"
    ],
    "Stress": [
      "There's so much pressure with collegework, I feel like I can't keep up.",
      "How do I handle stress from deadlines and assignments?",
      "I'm constantly feeling stressed, how do I reduce it?",
      "Can stress affect my health? How can I prevent burnout?",
      "I have too many responsibilities right now, how can I deal with it all?",
      "I have other query"
    ],
    "Sadness": [
      "I feel so down, I don't know how to keep going.",
      "Why am I so sad even though everything seems fine?",
      "What are some ways to cope with feeling hopeless?",
      "How do I know if I need professional help for my sadness?",
      "I can't seem to feel happy anymore, what should I do?",
      "I have other query"
    ],
    "Anger": [
      "I'm feeling really angry right now, what can I do to calm down?",
      "Why am I so irritated all the time?",
      "How can I manage my anger in a healthy way?",
      "I can't stop feeling angry at myself for making a mistake, how can I move on?",
      "I have other query"
    ],
    "Confusion/Indecision": [
      "I can't decide what to do with my future, how can I make a decision?",
      "I'm not sure if I'm on the right path, what should I do?",
      "I feel confused about my feelings toward someone. Can you help me sort them out?",
      "I'm overwhelmed with choices, how can I make clearer decisions?",
      "I don't know what I want out of life, how can I find direction?",
      "I have other query"
    ],
    "Happiness/Contentment": [
      "I'm feeling really good today, but I don't know why. Should I enjoy it?",
      "What can I do to feel more positive every day?",
      "I've had a good week, but I'm afraid it won't last. How can I stay grounded?",
      "I'm learning to appreciate small moments. Can you suggest ways to stay grateful?",
      "I have other query"
    ],
    "Fear": [
      "I'm scared about my future and what comes after college, how do I face this fear?",
      "I feel anxious about trying new things, how can I overcome that fear?",
      "I'm afraid of disappointing my parents. How can I deal with this fear?",
      "I have a fear of failure, how can I push past it?",
      "I'm scared to speak in public. What can I do to feel more confident?",
      "I have other query"
    ],
    "shame": [
      "I feel so ashamed of my actions, how can I forgive myself?",
      "I did something that I regret, how can I move past this shame?",
      "I feel like I'm not good enough. How can I stop feeling ashamed of myself?",
      "How can I stop letting shame control my actions?",
      "What can I do to feel more comfortable with who I am?",
      "I have other query"
    ],
    "Overwhelmed": [
      "I feel like there's so much going on, I don't know where to start. How can I prioritize?",
      "How can I break down everything I need to do when it feels like too much?",
      "I'm overwhelmed by everything happening in my life, how can I cope?",
      "I can't keep up with everything. How do I regain a sense of control?",
      "I'm constantly busy but never feel productive, how can I handle this?",
      "I have other query"
    ],
    "Frustrated": [
      "I'm feeling frustrated because I keep failing, how can I deal with it?",
      "I tried so hard, but nothing is working, what should I do?",
      "How do I handle situations where things don't go my way?",
      "I feel like I'm stuck and can't make progress, how can I get past this?",
      "What can I do when I'm frustrated with my own mistakes?",
      "I have other query"
    ],
  };

  // Define follow-up questions and their manual answers for each query under each emotion
  Map<String, Map<String, Map<String, String>>> followUpDetails = {
    "Guilt": {
      "I feel guilty for not doing enough, even though I'm trying my best.": {
        "I feel like I let my friends down by not helping enough.": "It's great that you recognize your efforts. Maybe talk to your friends to see how you can support each other next time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm struggling to balance everything, and it's making me feel worse.": "Balancing can be tough. Try making a small to-do list to prioritize tasks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel overwhelmed with my responsibilities.": "It's okay to feel overwhelmed. Break your tasks into smaller steps to manage better. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Please share more about what's on your mind, or let's go back to your original concerns."
      },
      "How do I stop feeling guilty about past decisions?": {
        "I keep replaying a mistake I made years ago.": "It's hard to let go, but focusing on the present can help. Try writing down your thoughts to process them. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't move forward because of my past.": "Moving forward is a step at a time. Consider setting a small goal to feel progress. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm afraid others judge me for my past.": "It's natural to worry about judgment. Focus on your growth instead. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Feel free to elaborate, or we can revisit your earlier questions."
      },
      "I hurt someone I care about, how can I make it right?": {
        "I said something hurtful during an argument.": "Apologizing sincerely can be a good start. Maybe write a note if talking feels hard. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I didn't realize how my actions affected them until now.": "Understanding is a big step. Reach out to them with empathy. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel too ashamed to face them.": "Shame can be tough. Start with a small gesture to show you care. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more if you'd like, or let's return to your initial query."
      },
      "I missed an important event, and now I feel like I've let everyone down, how can I cope?": {
        "It was a family event, and I couldn't attend due to work.": "It's okay to miss things sometimes. Maybe plan a call with your family to reconnect. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "My friends are upset with me for not showing up.": "Explain your situation to your friends; they might understand. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm always letting people down.": "That feeling can be heavy. Reflect on what you can control next time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your coping options."
      },
      "I didn't meet my own expectations, and now I feel worthless. What can I do?": {
        "I failed an exam I studied hard for.": "Failing doesn't define you. Reflect on what you learned and try again. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm not good enough compared to others.": "Everyone has their own pace. Focus on your strengths. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I keep doubting my abilities.": "Self-doubt can be tough. Celebrate small wins to build confidence. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "Loneliness": {
      "I feel really alone even when I'm surrounded by people, what can I do?": {
        "I feel like no one truly understands me.": "It's tough to feel that way. Try sharing one thing with someone you trust. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm at a party but still feel disconnected.": "That's common. Maybe start with a small conversation. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know how to connect with others.": "Connecting takes practice. Start with shared interests. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Feel free to elaborate, or let's return to your options."
      },
      "How do I make friends in college when I feel so isolated?": {
        "I'm shy and find it hard to approach people.": "Shyness is normal. Start with a smile or a hello. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like everyone already has their own groups.": "Groups can be welcoming. Try a club. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know where to start.": "Starting small helps. Attend a campus event. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your questions."
      },
      "I feel disconnected from everyone, even my family, what should I do?": {
        "I don't feel close to my family anymore.": "Distance can happen. Try a small gesture like a call. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't talk to anyone about my feelings.": "That's isolating. Journaling might help first. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm pushing people away.": "It's okay to need space. Reflect on why you're pushing. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I'm finding it hard to find my place at college, any advice?": {
        "I don't feel like I fit in with my classmates.": "Fitting in takes time. Look for shared interests. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm struggling to join clubs or activities.": "Clubs can feel daunting. Start with one event. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I don't belong here.": "That feeling can pass. Focus on what you enjoy. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I miss home and feel lonely here, how can I cope with this feeling?": {
        "I'm far away from my family and friends.": "Distance is hard. Schedule regular calls. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel homesick and don't know how to adjust.": "Homesickness is normal. Create a routine here. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'll never fit in.": "It takes time to adjust. Find small comforts. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "Anxiety": {
      "I'm constantly worrying about my future, how can I stop overthinking?": {
        "I'm scared I won't get a good job after college.": "It's normal to worry about jobs. Start by exploring your skills. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I keep imagining worst-case scenarios.": "That's a common anxiety pattern. Try grounding techniques. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't control my thoughts.": "Overthinking can be tough. Focus on the present. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I get really anxious before exams, what can help me feel more in control?": {
        "I feel like I'm going to fail no matter how much I study.": "That fear is common. Break your study into chunks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "My heart races, and I can't focus during the exam.": "Physical symptoms can be managed. Try deep breathing. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I freeze up when I see the questions.": "Freezing is tough. Practice with mock exams. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "How can I manage the feeling of being overwhelmed with everything?": {
        "I have too many assignments and don't know where to start.": "Start small with a to-do list. Prioritize tasks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm falling behind in all my classes.": "Falling behind feels heavy. Focus on one class at a time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I can't handle the pressure.": "Pressure can be intense. Take breaks to recharge. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "I can't seem to relax, even when I try, what should I do?": {
        "I feel restless even when I have free time.": "Restlessness can be hard. Try a calming activity. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "My mind won't stop racing with thoughts.": "Racing thoughts are tough. Try mindfulness exercises. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel tense all the time.": "Tension can build up. Deep breathing might help. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
      "I feel nervous meeting new people, is that normal?": {
        "I worry they won't like me.": "That worry is common. Be yourself—they'll appreciate it. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I get anxious about saying the wrong thing.": "It's okay to make mistakes. Start with small talk. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel judged when I meet new people.": "Feeling judged is tough. Focus on shared interests. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's return to your options."
      },
    },
    "Stress": {
      "There's so much pressure with collegework, I feel like I can't keep up.": {
        "I have multiple deadlines approaching.": "Deadlines can feel heavy. Prioritize tasks with a schedule. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm not doing well in my classes.": "That feeling can be tough. Focus on one subject at a time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm overwhelmed by expectations.": "Expectations can be intense. Set realistic goals. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "How do I handle stress from deadlines and assignments?": {
        "I procrastinate and then panic at the last minute.": "Procrastination is common. Break tasks into smaller steps. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't focus because of the stress.": "Stress can affect focus. Try a short mindfulness break. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel overwhelmed by the workload.": "Workload can be heavy. Prioritize and take breaks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I'm constantly feeling stressed, how do I reduce it?": {
        "I feel stressed even when I'm not working.": "Stress can linger. Try a relaxing hobby. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm having trouble sleeping because of stress.": "Sleep issues are tough. Create a bedtime routine. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't escape it.": "Feeling trapped is hard. Take small breaks to recharge. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
      "Can stress affect my health? How can I prevent burnout?": {
        "I've been feeling tired and unmotivated lately.": "Stress can cause fatigue. Prioritize rest and small wins. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm worried I'll get sick from being so stressed.": "Stress can impact health. Focus on basics like sleep and diet. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel close to burning out.": "Burnout is serious. Take a break and set boundaries. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "I have too many responsibilities right now, how can I deal with it all?": {
        "I'm juggling college, work, and family responsibilities.": "That's a lot to handle. Delegate if possible. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I don't have time for myself.": "Self-time is important. Schedule a small break. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel overwhelmed by everything.": "It's okay to feel overwhelmed. Prioritize tasks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's revisit your queries."
      },
    },
    "Sadness": {
      "I feel so down, I don't know how to keep going.": {
        "I've lost interest in things I used to enjoy.": "Losing interest can be a sign of sadness. Try small activities. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like nothing will get better.": "Hopelessness is heavy. Focus on one day at a time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel isolated and alone.": "Isolation can worsen sadness. Reach out to someone. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "Why am I so sad even though everything seems fine?": {
        "I don't have any obvious reason to feel this way.": "Sadness can come without reason. Reflect on your feelings. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel empty despite having a good life.": "Emptiness can be tough. Find small joys. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm hiding my sadness.": "Hiding feelings is hard. Share with someone safe. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's revisit your queries."
      },
      "What are some ways to cope with feeling hopeless?": {
        "I feel like giving up on my goals.": "Hopelessness can be heavy. Set a small goal to feel progress. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't see a light at the end of the tunnel.": "It's hard to feel that way. Focus on small wins. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm stuck.": "Feeling stuck is tough. Try a new routine. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "How do I know if I need professional help for my sadness?": {
        "I've been feeling sad for weeks and can't shake it.": "Persistent sadness might need help. A counselor can support you. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm starting to feel like I can't function normally.": "That's a sign to seek help. It's okay to ask. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm scared to reach out for help.": "It's brave to seek help. Start with a small step. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
      "I can't seem to feel happy anymore, what should I do?": {
        "I used to enjoy things, but now I don't.": "Losing joy is hard. Try small activities you loved. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm just going through the motions.": "That can feel empty. Find a small purpose. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel disconnected from happiness.": "Reconnecting takes time. Focus on self-care. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
    },
    "Anger": {
      "I'm feeling really angry right now, what can I do to calm down?": {
        "I just had a stressful encounter with a classmate, and I can't stop thinking about it.": "That sounds overwhelming. Taking a step back and giving yourself some time to process it can help. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel tense, and I just want to yell.": "Anger can build up quickly, and it's okay to feel that way. Taking deep breaths or stepping away from the situation might help. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm going to explode if I don't let it out.": "That intensity is tough. Try a physical outlet like exercise. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Please share more about what's on your mind, or let's go back to your original concerns."
      },
      "Why am I so irritated all the time?": {
        " I feel irritated with people and situations, even little things like noise or waiting in line.": "It might be a sign of built-up stress. Try identifying triggers and taking short breaks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I've been too busy to relax.": "Taking short breaks throughout the day can really help reduce irritability. If these feelings of irritation continue, talking to a counselor might help you find effective ways to cope with stress and manage your emotions. Would you like information on how to meet with a counselor?",
        "I have a lot of assignments piling up, and I feel like I don't have time to relax.":"That could definitely contribute to irritability. When you're stressed or overwhelmed, it's common to become more easily frustrated. Have you been able to set aside time for self-care or relaxation, even just for a few minutes a day?You should connect with a counselor to get the right support. Say 'Yes' to proceed." ,
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "How can I manage my anger in a healthy way?": {
        "I tend to snap at people when I'm angry.": "That's a common reaction. Practice pausing before responding. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know how to express my anger without hurting others.": "Expressing anger safely is key. Try writing it down first. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel guilty after I get angry.": "Guilt after anger is normal. Reflect on what happened. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I can't stop feeling angry at myself for making a mistake, how can I move on?": {
        "I messed up on a project, and I'm so mad at myself.": "Mistakes happen. Focus on what you can learn. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I keep beating myself up over a mistake I made.": "Be kind to yourself. Try a positive affirmation. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm a failure because of this.": "One mistake doesn't define you. Celebrate your efforts. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "Confusion/Indecision": {
      "I can't decide what to do with my future, how can I make a decision?": {
        "I'm torn between two career paths.": "It's a tough choice. List pros and cons for each. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know what I'm passionate about.": "Passion takes time to find. Explore different interests. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel pressured to decide quickly.": "Pressure can make it harder. Take a step back. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "I'm not sure if I'm on the right path, what should I do?": {
        "I'm questioning my major in college.": "Questioning is normal. Research other majors. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I might be wasting my time.": "That worry can be heavy. Reflect on your goals. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know what's right for me.": "Finding what's right takes time. Try new things. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I feel confused about my feelings toward someone. Can you help me sort them out?": {
        "I don't know if I like them romantically or as a friend.": "It's okay to be unsure. Reflect on how they make you feel. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm getting mixed signals from them.": "Mixed signals can be confusing. Communicate openly. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel anxious about my feelings.": "Anxiety can cloud feelings. Take it slow. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I'm overwhelmed with choices, how can I make clearer decisions?": {
        "I have too many options for my next step.": "Too many choices can be hard. Narrow them down. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm afraid of making the wrong choice.": "Fear of mistakes is normal. Focus on what aligns with your values. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel paralyzed by indecision.": "Indecision can be paralyzing. Start with a small step. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "I don't know what I want out of life, how can I find direction?": {
        "I feel lost and don't have any goals.": "Feeling lost is okay. Start with small goals. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know where to start looking for purpose.": "Purpose can come from exploration. Try new things. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm drifting aimlessly.": "Drifting can feel unsettling. Reflect on what matters. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "Happiness/Contentment": {
      "I'm feeling really good today, but I don't know why. Should I enjoy it?": {
        "I'm worried it won't last long.": "It's okay to enjoy the moment. Savor it fully. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel guilty for feeling happy when others aren't.": "Your happiness matters. Share positivity with others. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I want to make the most of this feeling.": "That's great! Do something you love. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "What can I do to feel more positive every day?": {
        "I want to maintain a positive outlook.": "Positivity takes practice. Start with gratitude. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I want to find more joy in small things.": "Small joys add up. Notice little moments. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I lose positivity quickly.": "It's normal to fluctuate. Create a positivity routine. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I've had a good week, but I'm afraid it won't last. How can I stay grounded?": {
        "I'm scared something bad will happen soon.": "That fear is common. Focus on the present. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know how to handle this fear of losing happiness.": "It's okay to feel this way. Practice mindfulness. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I want to keep this feeling going.": "Sustaining happiness takes effort. Build positive habits. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I'm learning to appreciate small moments. Can you suggest ways to stay grateful?": {
        "I want to keep a gratitude journal but don't know how to start.": "A journal is great. Write 3 things daily. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I want to share positivity with others.": "Sharing spreads joy. Compliment someone. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I struggle to stay consistent.": "Consistency takes practice. Set a reminder. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      
    },
    "Fear": {
      "I'm scared about my future and what comes after college, how do I face this fear?": {
        "I don't know if I'll be successful after graduating.": "Success varies for everyone. Focus on your skills. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm afraid of not being prepared for the real world.": "Preparation takes time. Start with small steps. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel overwhelmed by the uncertainty.": "Uncertainty can be scary. Plan what you can. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "I feel anxious about trying new things, how can I overcome that fear?": {
        "I want to join a new club but I'm scared.": "Trying new things is brave. Start with a small step. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm afraid of failing at something new.": "Failure is part of growth. Focus on learning. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel too nervous to take the first step.": "Nerves are normal. Take it slow. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I'm afraid of disappointing my parents. How can I deal with this fear?": {
        "I feel pressure to meet their expectations.": "Pressure can be heavy. Communicate with them. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm scared they'll be upset if I don't succeed.": "Their reaction isn't your fault. Focus on your efforts. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm living for them, not me.": "Living for yourself matters. Set your own goals. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I have a fear of failure, how can I push past it?": {
        "I avoid challenges because I'm afraid of failing.": "Avoidance can hold you back. Start small. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel paralyzed when I think about failing.": "That fear can be strong. Reframe failure as learning. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like failure defines me.": "Failure doesn't define you. Focus on growth. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "I'm scared to speak in public. What can I do to feel more confident?": {
        "I get nervous even thinking about presenting.": "Nerves are normal. Practice in small groups. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm worried I'll mess up in front of everyone.": "Mistakes happen. Focus on your message. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like everyone is judging me.": "Judgment fears are common. Focus on your strengths. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "shame": {
      "I feel so ashamed of my actions, how can I forgive myself?": {
        "I did something I'm not proud of in front of others.": "Shame can be heavy. Reflect on what you learned. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I can't stop thinking about my mistake.": "Rumination is tough. Write down your thoughts. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm a bad person.": "One action doesn't define you. Focus on your values. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "I did something that I regret, how can I move past this shame?": {
        "I hurt someone and feel terrible about it.": "Regret shows growth. Apologize if you can. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like everyone is judging me.": "Judgment can feel heavy. Focus on your growth. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel stuck in my shame.": "Shame can trap you. Take small steps to heal. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I feel like I'm not good enough. How can I stop feeling ashamed of myself?": {
        "I compare myself to others and feel inferior.": "Comparison is tough. Focus on your strengths. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel ashamed of my appearance or abilities.": "Self-worth isn't about looks. Celebrate who you are. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'll never be enough.": "That feeling can be heavy. Build confidence slowly. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "How can I stop letting shame control my actions?": {
        "I avoid situations because I'm ashamed.": "Avoidance can limit you. Face small fears. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like shame is holding me back.": "Shame can be powerful. Work on self-acceptance. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know how to break free.": "Breaking free takes time. Start with self-kindness. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "What can I do to feel more comfortable with who I am?": {
        "I struggle with self-acceptance.": "Acceptance is a journey. Focus on your values. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel ashamed of my past experiences.": "Your past doesn't define you. Embrace your growth. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I don't fit in.": "Fitting in isn't the goal. Be yourself. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "Overwhelmed": {
      "I feel like there's so much going on, I don't know where to start. How can I prioritize?": {
        "I have too many tasks and can't focus.": "Too many tasks can be hard. Write a priority list. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm drowning in responsibilities.": "That feeling is tough. Focus on one task at a time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know what's most important.": "Prioritizing can be tricky. Start with deadlines. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "How can I break down everything I need to do when it feels like too much?": {
        "I have a big project and don't know where to begin.": "Big projects can feel daunting. Break it into steps. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel overwhelmed by my daily tasks.": "Daily tasks can pile up. Start with the easiest. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm not making progress.": "Progress can feel slow. Celebrate small wins. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "I'm overwhelmed by everything happening in my life, how can I cope?": {
        "I have personal and academic pressures piling up.": "That's a lot to handle. Take a break to recharge. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't handle everything going on.": "It's okay to feel this way. Focus on what you can control. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm failing at everything.": "You're not failing. Take it one step at a time. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I can't keep up with everything. How do I regain a sense of control?": {
        "I feel like I'm always behind on my work.": "Falling behind is tough. Create a schedule. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know how to manage my time.": "Time management can be learned. Start with a planner. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm losing control.": "Regaining control takes small steps. Focus on one task. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "I'm constantly busy but never feel productive, how can I handle this?": {
        "I feel like I'm working hard but getting nowhere.": "That can be frustrating. Focus on key tasks. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I'm overwhelmed by my schedule.": "A packed schedule is tough. Simplify where you can. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm wasting my time.": "Feeling unproductive is hard. Track your progress. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
    "Frustrated": {
      "I'm feeling frustrated because I keep failing, how can I deal with it?": {
        "I failed a test despite studying hard.": "Failing is tough. Reflect on what to improve. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm not improving no matter what I do.": "Improvement takes time. Focus on small gains. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like giving up.": "Giving up can feel tempting. Take a break instead. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's go back to your options."
      },
      "I tried so hard, but nothing is working, what should I do?": {
        "I worked on a project, but it didn't turn out well.": "That's disappointing. Learn from it and try again. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm hitting a wall with my efforts.": "Hitting a wall is frustrating. Try a new approach. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm wasting my effort.": "Effort isn't wasted if you learn. Reflect on this. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's revisit your queries."
      },
      "How do I handle situations where things don't go my way?": {
        "I get frustrated when plans change unexpectedly.": "Change can be hard. Practice flexibility. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I can't control anything.": "Lack of control is tough. Focus on what you can manage. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel angry when things don't go as planned.": "Anger is normal. Take a moment to breathe. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more, or let's return to your options."
      },
      "I feel like I'm stuck and can't make progress, how can I get past this?": {
        "I'm struggling to improve in my studies.": "Struggling can be frustrating. Try new study methods. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm not moving forward in life.": "Feeling stuck is hard. Set a small goal. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I don't know how to break this cycle.": "Breaking cycles takes effort. Start with a change. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Tell me more, or let's go back to your options."
      },
      "What can I do when I'm frustrated with my own mistakes?": {
        "I made a mistake and can't stop thinking about it.": "Mistakes can linger. Learn and let go. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I'm letting myself down.": "You're not a failure. Focus on growth. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "I feel like I should be better.": "Perfection isn't the goal. Celebrate effort. You should connect with a counselor to get the right support. Say 'Yes' to proceed.",
        "another reason": "Share more details, or let's revisit your queries."
      },
    },
  };

  List<String> emotions = [
    "Anger",
    "Loneliness",
    "Guilt",
    "Anxiety",
    "Stress",
    "Sadness",
    "Confusion/Indecision",
    "Fear",
    "shame",
    "Overwhelmed",
    "Frustrated",
    "Happiness/Contentment",
    "other"
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        messages.add({"bot": "How are you feeling today?"});
        messages.add({"options": emotions, "type": "emotion"});
      });
    });
  }

  void selectEmotion(String emotion) async {
    setState(() {
      currentEmotion = emotion; // Store the selected emotion
      currentQuery = null; // Reset the current query
      currentSubQuery = null; // Reset the current subquery
      messages.add({"user": emotion});
      if (emotion != "other" && emotion != "I have other query") {
        messages.add({"bot": "Choose your query:"});
        messages.add({"options": emotionQuestions[emotion] ?? [], "type": "question"});
      } else {
        // Add the response for "other" and "I have other query"
        messages.add({"bot": "I understand that you may have more concerns. Speaking to a counselor can provide the best support for your well-being. Would you like to book an appointment?"});
        messages.add({"options": ["✅ Yes, book an appointment", "❌ Not now"], "type": "appointment"});
      }
    });
    if (emotion != "other") {
      await saveToFile(emotion);
      await sendEmail(emotion);
    }
    _scrollToBottom();
  }

  void selectQuestion(String question) {
    setState(() {
      currentQuery = question; // Store the selected query
      currentSubQuery = null; // Reset the current subquery
      messages.add({"user": question});
      if (question == "I have other query") {
        messages.add({"bot": "I understand that you may have more concerns. Speaking to a counselor can provide the best support for your well-being. Would you like to book an appointment?"});
        messages.add({"options": ["✅ Yes, book an appointment", "❌ Not now"], "type": "appointment"});
      } else {
        // Add the three specific follow-up options for the selected query and "another reason"
        messages.add({"bot": "Can you tell me more?"});
        List<String> followUps = followUpDetails[currentEmotion]?.containsKey(question) == true
            ? followUpDetails[currentEmotion]![question]!.keys.toList()
            : ["I'm not sure how to explain it.", "It's a bit complicated.", "another reason"];
        messages.add({"options": followUps, "type": "followup"});
      }
    });
    _scrollToBottom();
  }

  void selectAppointmentOption(String option) {
    setState(() {
      messages.add({"user": option});
      if (option == "✅ Yes, book an appointment") {
        // Navigate to AssessmentScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CounsellingScreen()),
        );
      } else {
        messages.add({"bot": "Thank you for communicating with me. Feel free to come back anytime if you need support. Take care!"});
      }
    });
    _scrollToBottom();
  }

  void selectFollowupOption(String option) {
    setState(() {
      currentSubQuery = option; // Store the selected subquery
      messages.add({"user": option});
      if (option == "another reason") {
        messages.add({"bot": "Please share more about what's on your mind, or let's go back to your original concerns."});
        messages.add({"options": emotionQuestions[currentEmotion] ?? [], "type": "question"});
      } else {
        // Fetch the manual answer using the stored currentQuery
        String? answer = followUpDetails[currentEmotion]?[currentQuery]?[option];
        messages.add({"bot": answer ?? "I'm here to help. Let me know how I can assist further!"});
        // Replace the old options with "Yes, connect me" and "Not now"
        messages.add({"options": ["✅ Yes, connect me", "❌ Not now"], "type": "counselor"});
      }
    });
    _scrollToBottom();
  }

  Future<void> saveToFile(String emotion) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_emotions.txt');
      await file.writeAsString('$emotion\n', mode: FileMode.append);
    } catch (e) {
      print("Error saving emotion to file: $e");
    }
  }

  Future<void> sendEmail(String emotion) async {
    String username = "your_email@gmail.com"; // Replace with your email
    String password = "your_app_specific_password"; // Replace with your app-specific password

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, "Mental Health AI")
      ..recipients.add("manvi.cs22@bmsce.ac.in")
      ..subject = "User Emotion Report"
      ..text = "User selected emotion: $emotion";

    try {
      await send(message, smtpServer);
      print("Email sent successfully");
    } catch (e) {
      print("Email failed: $e");
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat with AI",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 138, 103, 90),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 249, 239, 197), // Colors.white ,// 
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.83, // Covers 3/4 of the screen height
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  if (message.containsKey("bot")) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.66, // This makes the box 2/3 of screen width
                        ),
                        margin: EdgeInsets.only(top: 15, bottom: 2, left: 10, right: 100), // Increased right padding to 120
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),//choose query box
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          message["bot"],
                          style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  } else if (message.containsKey("user")) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5, left: 80, right: 30), // Increased right padding to 30
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 249, 232, 182),
                          borderRadius: BorderRadius.circular(8),//user response box
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          message["user"],
                          style: TextStyle(fontSize: 14 ,color: Colors.black, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  } else if (message.containsKey("options")) {
                    return _buildOptions(message["options"], message["type"]);
                  }
                  return SizedBox.shrink();
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(List<String> options, String type) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: type == "question"
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.75, // Limit width to 75% for query options
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: options.map((option) {
                  return Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.25), // Right padding for query options
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65, // Optional: Constrain button width
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (currentQuery != null && currentQuery != option) 
                              ? Colors.grey // Grey out if another query is already selected
                              : Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: (currentQuery != null && currentQuery != option)
                            ? null // Disable if another query is already selected
                            : () {
                                if (type == "emotion") {
                                  selectEmotion(option);
                                } else if (type == "question") {
                                  selectQuestion(option);
                                } else if (type == "appointment") {
                                  selectAppointmentOption(option);
                                } else if (type == "followup") {
                                  selectFollowupOption(option);
                                } else if (type == "counselor") {
                                  setState(() {
                                    messages.add({"user": option});
                                    if (option == "✅ Yes, connect me") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CounsellingScreen()),
                                      );
                                    } else {
                                      messages.add({"bot": "Thank you for communicating with me. Feel free to come back anytime if you need support. Take care!"});
                                    }
                                  });
                                  _scrollToBottom();
                                }
                              },
                        child: Text(option, style: TextStyle(fontSize:14 , color: Colors.black, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : Wrap( 
              spacing: 8.0,
              runSpacing: 8.0,
              children: options.map((option) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (type == "emotion" && currentEmotion != null && currentEmotion != option) ||
                                 (type == "followup" && currentSubQuery != null && currentSubQuery != option) ||
                                 (type == "appointment" && messages.last["user"] != null)
                        ? Colors.grey // Grey out if already selected
                        : type == "emotion" ? Colors.white : Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: (type == "emotion" && currentEmotion != null && currentEmotion != option) ||
                             (type == "followup" && currentSubQuery != null && currentSubQuery != option) ||
                             (type == "appointment" && messages.last["user"] != null)
                      ? null // Disable if already selected
                      : () {
                          if (type == "emotion") {
                            selectEmotion(option);
                          } else if (type == "question") {
                            selectQuestion(option);
                          } else if (type == "appointment") {
                            selectAppointmentOption(option);
                          } else if (type == "followup") {
                            selectFollowupOption(option);
                          } else if (type == "counselor") {
                            setState(() {
                              messages.add({"user": option});
                              if (option == "✅ Yes, connect me") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CounsellingScreen()),
                                );
                              } else {
                                messages.add({"bot": "Thank you for communicating with me. Feel free to come back anytime if you need support. Take care!"});
                              }
                            });
                            _scrollToBottom();
                          }
                        },
                  child: Text(option, style: TextStyle(fontSize:14, color:  Colors.black ,fontWeight: FontWeight.w400) ),
                );
              }).toList(),
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatScreen(),
  ));
}