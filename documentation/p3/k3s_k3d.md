k3s = La distribution Kubernetes legere creee par Rancher Labs.

k3d = un outil pour executer k3s dans des conteneurs Docker, pratique pour le developpement local.

1. k3s
    C’est une version allégée de Kubernetes, pensée pour :

        Les petites machines (Raspberry Pi, VM légères…)
        L’IoT (Internet des objets)
        Les environnements edge computing

    Il remplace certaines dépendances lourdes (par ex. etcd → SQLite par défaut) pour consommer moins de ressources.

    Fonctionne sans Docker obligatoire (peut utiliser containerd intégré).

    Peut être installé directement sur une machine (bare metal ou VM) et tourner comme un “vrai” cluster.

    ⚡ Avantages :

        Léger, rapide à démarrer.
        Compatible avec Kubernetes standard.
        Peut tourner sur une seule machine ou en cluster distribué.

2. k3d

    C’est un wrapper qui te permet de lancer k3s dans des conteneurs Docker.

    En gros : tu installes k3d → il va créer un ou plusieurs conteneurs Docker → dans ces conteneurs tourne k3s.

    Parfait pour tester localement sur ton PC :

        Pas besoin de VM.
        Pas besoin d’installer k3s directement sur ta machine.
        Facile à supprimer/recréer en quelques secondes.

    ⚡ Avantages :

        Hyper rapide pour créer/détruire un cluster.
        Idéal pour du dev ou de la formation.
        Peut simuler un cluster multi-nœuds dans un seul Docker host.

💡 On peut retenir :

    k3s = le Kubernetes léger.
    k3d = le moyen simple de lancer k3s dans Docker (dev local).
